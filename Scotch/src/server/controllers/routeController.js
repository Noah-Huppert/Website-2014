/* Setup namespace */
var scotch = {};
scotch.controllers = {};
scotch.controllers.router = {};

scotch.controllers.view = rekuire("controllers/viewController.js");


/* Routes */
scotch.controllers.router.register = function(app){
  app.get("/", function(req, res){
    scotch.controllers.view.render(res, "mainPage");
  });
};


module.exports = scotch.controllers.router;
