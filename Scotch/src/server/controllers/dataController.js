/* Scotch namespace */
var scotch = {};
scotch.controllers = {};

scotch.controllers.data = {};


/* Require */
scotch.controllers.database = rekuire("controllers/databaseController.js");
scotch.controllers.log = rekuire("controllers/logController.js");


/* Actions */
scotch.controllers.data.posts = function(callback){
  function connectedToDatabase(err, collection){
    collection.find().toArray(fetchedPostsData);
  }

  function fetchedPostsData(err, data){
    if(!!err){
      scotch.controllers.log.error(err, "scotch.controllers.data.posts.fetchedPostsData");
    }

    if(data.length === 0){
      data = {};
    }

    callback(err, data);
  }

  scotch.controllers.database.collection("posts", connectedToDatabase);
};

scotch.controllers.data.projects = function(callback){
  function connectedToDatabase(err, collection){
    collection.find().toArray(fetchedPostsData);
  }

  function fetchedProjectsData(err, data){
    if(!!err){
      scotch.controllers.log.error(err, "scotch.controllers.data.projects.fetchedProjectsData");
    }

    if(data.length === 0){
      data = {};
    }

    callback(err, data);
  }

  scotch.controllers.database.collection("projects", connectedToDatabase);
};

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
