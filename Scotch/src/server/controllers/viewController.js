/* Scotch namespace */
var scotch = {};
scotch.controllers = {};

scotch.controllers.view = {};


/* Require */
scotch.controllers.data = rekuire("controllers/dataController.js");


/* Render */
scotch.controllers.view.render = function(res, pageId, callback){
  var site = {};
  var page = {};

  function siteDataFetched(err, siteData){
    site = siteData;

    scotch.controllers.data.page(pageId, pageDataFetched);
  }

  function pageDataFetched(err, pageData){
    page = pageData;

    renderPage();
  }

  function renderPage(){
    var data = {
      "site": site,
      "page": page
    };

    res.render(pageId + ".handlebars", data);

    if(callback !== undefined){
      callback(site, page);
    }
  }

  scotch.controllers.data.site(siteDataFetched);
};


module.exports = scotch.controllers.view;
