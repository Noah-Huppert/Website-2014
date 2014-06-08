/* Setup */
var codeing = require('node-codein');
console.log('---------------------------------------------------------------- Server Restart ID: ' + Date.now().toString().substring(Date.now().toString().length - 5, Date.now().toString().length) + " @ " + new Date() + " ----------------------------------------------------------------");
//Includes
var express = require('express');
var app = express();

var fs = require('fs');

var expressHandlebars = require('express3-handlebars');
var handlebars = expressHandlebars.create();

var mongo = require('mongodb');
var async = require('async');
//Express
app.use(express.static(__dirname + '/public'));

app.set('views', __dirname + '/views');

app.engine('handlebars', expressHandlebars({ defaultLayout: 'main' }));
app.set('view engine', 'handlebars');
//Mongo DB
var dbURL = "mongodb://root:theraininspain@dbh55.mongolab.com:27557/home";

function useDB(collectionName, cb){
	mongo.connect(dbURL, function(err, db){
		if(err) throw err;

		var collection = db.collection(collectionName);

		if(!!cb){
			cb(db, collection);
		}

	});
}


/* Rendering */
function renderBranch(branchSlug, pageSlug, renderer){

	function getBranchData(cb){
		useDB('branches', function(db, collection){

			collection.find({ "slug": branchSlug }).toArray(function(err, data){

				var branchData = data[0];

				if(!!branchData && branchData.length !== 0){//Branch exists
					getPageData(branchData);
				} else{//Branch does not exists
					renderError('nobranch');
				}

				if(!!cb){
					cb(branchData);
				}

			});

		});
	}

	function getPageData(branchData, cb){
		var renderPageSlug = !!pageSlug ? pageSlug : branchData.main;

		useDB(branchData.dbname, function(db, collection){

			collection.find({ "slug": renderPageSlug }).toArray(function(err, data){

				var pageData = data[0];

				if(!!pageData && pageData.length !== 0){//Page exists
					getPageRequireData(pageData, function(requireData){
						pageData.require = requireData;

						if(!!cb){
							cb(pageData);
						} else{
							getSiteData(branchData, pageData);
						}
					});
				} else{//Page does not exist
					renderError('nopage');
					if(!!cb){
						cb(pageData);
					}
				}

			});

		});
	}

	function getPageRequireData(pageData, cb){

		if(!!pageData.require && pageData.require.length !== 0){//Require exists

			var returnData = [];

			var iterator = function (item, cb){
				var branch = Object.keys(item)[0];
				var needed = item[branch];

				useDB('branches', function(db, collection){

					collection.find({ "slug": branch }).toArray(function(err, data){
						var branchData = data[0];

						if(!!branchData && branchData.length !== 0){//Branch Exists
							switch(needed){
								case 'dbdata':
									useDB(branchData.dbname, function(db, collection){
										collection.find({}).toArray(function(err, data){
											returnData[branch + ":" + needed] = data;
											cb();
										});
									});
								break;

								default:
									returnData[branch + ":" + needed] = branchData[needed];
									cb();
								break;
							}
						} else{
							cb();
						}
					});

				});
			};

			var callback = function(err){
				if(!!cb){
					cb(returnData);
				}
			};

			async.each(pageData.require, iterator, callback);
		} else{//Require doesnt exist
			if(!!cb){
				cb({});
			}
		}

	}

	function getSiteData(branchData, pageData, cb){

		var siteData = {};

		useDB('site', function(db, collection){

			collection.find({}).toArray(function(err, data){
				var siteData = data[0];

				if(!!cb){
					cb(siteData);
				} else{
					renderPage(branchData, pageData, siteData);
				}
			});

		});

	}

	function renderPage(branchData, pageData, siteData){
		renderer.res.render("content/branches/" + branchData.slug + "/" + pageData.slug, { "site": siteData, "branch": branchData, "page": pageData });
	}

	function renderError(errorType){
		console.log("renderError", errorType);
		getSiteData({}, {}, function(siteData){

			switch(errorType){
				case 'nobranch':
					doErrorRender(
						siteData,
						{
							"error": "The branch '" + branchSlug + "' does not exist, please check your spelling"
						},
						404);
				break;

				case 'nopage':
					doErrorRender(
						siteData,
						{
							"error": "The page '" + pageSlug + "' in the '" + branchSlug + "' does not exist, please check your spelling"
						},
						404);
				break;
			}

			function doErrorRender(siteData, pageData, status){
				renderer.res.status(status);
				renderer.res.render('content/errors/404', { "site": siteData, "page": pageData });
			}

		});
	}

	getBranchData();
}

function renderFile(fileType, filePath, renderer){

	function getSiteData(cb){

		useDB('site', function(db, collection){

			collection.find({}).toArray(function(err, data){
				var siteData = data[0];

				if(!!cb){
					cb(siteData);
				} else{
					render(siteData);
				}
			});

		});

	}

	function render(siteData, cb){

		fs.exists('views/' + fileType + '/' + filePath + '.handlebars', function(exists){
			if(exists){//File exists
				app.render(fileType + '/' + filePath + '.handlebars', { "site": siteData, "layout": "raw" }, function(err, data){
					switch(fileType){
						case 'css':
							renderer.res.header("Content-type", "text/css");
						break;

						case 'js':
							renderer.res.header("Content-type", "application/javascript");
						break;

						default:
						renderer.res.header("Content-type", "text/html");
						break;
					}
					renderer.res.send(data);
				});
			} else{
				renderer.res.status(404);
				renderer.res.end();
			}
		});

	}

	getSiteData();
}


/* Helpers */
function getParam(req, param){
	return req.params[param];
}


/* Routing */
//Site
app.get('/', function(req, res){
	renderBranch('main', undefined, { "req": req, "res": res });
});

app.get('/:branch', function(req, res){
	var branch = getParam(req, 'branch');

	renderBranch(branch, undefined, { "req": req, "res": res });
});

app.get('/:branch/:page', function(req, res){
	var branch = getParam(req, 'branch');
	var page = getParam(req, 'page');

	renderBranch(branch, page, { "req": req, "res": res });
});
//Content
app.get('/render/:type/:filename', function(req, res){
	var type = getParam(req, 'type');
	var filename = getParam(req, 'filename');

	renderFile(type, filename, { "req": req, "res": res });
});



app.listen(3000);
