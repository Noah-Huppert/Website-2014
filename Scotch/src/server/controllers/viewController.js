/* Scotch namespace */
var scotch = {};
scotch.controllers = {};

scotch.controllers.view = {};


/* Require */
scotch.controllers.data = require(__dirname + "/dataController.js");

/* Config */
scotch.controllers.view.viewDir = __dirname + "/../client/views/";


/* Render */
scotch.controllers.view.render = function(res, pageId, callback){
  var site = {};
  var page = {};

  function siteDataFetched(err, site){
    site = site;

    scotch.controllers.data.page(pageId, pageDataFetched);
  }

  function pageDataFetched(err, page){
    page = page;

    renderPage();
  }

  function renderPage(){
    res.render(pageId + ".html.hbs");

    if(callback !== undefined){
      callback(site, page);
    }
  }

  scotch.controllers.data.site(siteDataFetched);
};


module.exports = scotch.controllers.view;
