/* Scotch namespace */
var scotch = {};
scotch.controllers = {};

scotch.controllers.data = {};


/* Require */
scotch.controllers.database = require(__dirname + "/databaseController.js");
scotch.controllers.log = require(__dirname + "/logController.js");


/* Actions */
scotch.controllers.data.site = function(callback){
  function connectedToDatabase(err, collection){
    collection.find().toArray(fetchedSiteData);
  }

  function fetchedSiteData(err, data){
    if(!!err){
      scotch.controllers.log.error(err, "scotch.controllers.data.site.fetchedSiteData");
    }

    if(data.length === 0){
      scotch.controllers.log.error("No site data found", "scotch.controllers.data.site.fetchedSiteData");
    }

    callback(err, data[0]);
  }

  scotch.controllers.database.collection("site", connectedToDatabase);
};

scotch.controllers.data.page = function(pageId, callback){
  function connectedToDatabase(err, collection){
    collection.find({"pageId": pageId}).toArray(fetchedPageData);
  }

  function fetchedPageData(err, data){
    if(!!err){
      scotch.controllers.log.error(err, "scotch.controllers.data.page.fetchedPageData");
    }

    if(data.length === 0){
      scotch.controllers.log.error("No page data found", "scotch.controllers.data.page.fetchPageData");
    }

    if(data.length > 1){
      scotch.controllers.log.error("More than 1 page found", "scotch.controllers.data.page.fetchPageData");
    }

    if(data[0].title === undefined){
      data[0].title = pageId;
    }

    callback(err, data[0]);
  }

  scotch.controllers.database.collection("pages", connectedToDatabase);
};


module.exports = scotch.controllers.data;
