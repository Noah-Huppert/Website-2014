/* Setup namespace */
var scotch = {};
scotch.db = {};
scotch.config = {};


/* Setup dependencies */
var express = require("express");
var app = express();
var mongodb = require("mongodb");
var expressHbs = require("express3-handlebars");
var fileSystem = require("fs");


/* Setup Express */
app.set("views", __dirname + "/src/client/views");
app.engine("hbs", expressHbs({extname:"html.hbs", defaultLayout:"main"}));
app.set("view engine", "hbs");


/* Database */
scotch.db.use = function(cName, callback){
  var url = "mongodb://node:theraininspain@ds033709.mongolab.com:33709/scotch";

  mongodb.connect(url, function(err, db){
    var collection = db.collection(cName);

    callback(collection);
  });
};


/* Routes */
app.get("/", function(req, res){

  function connectToSiteDatabase(){
      scotch.db.use("site", getSiteData);
  }

  function getSiteData(collection){
    collection.find().toArray(function(err, data){
      renderPage(data[0]);
    });
  }

  function renderPage(site){
    var data = {
      "site": site
    };

    res.render("mainPage.html.hbs", data);
  }

  connectToSiteDatabase();
});

app.listen(3000, function(){
  console.log("Server is watching on port " + 3000);
});
