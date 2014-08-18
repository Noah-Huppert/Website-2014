/* Setup namespace */
var scotch = {};
scotch.controllers = {};
scotch.controllers.router = {};

scotch.controllers.view = rekuire("controllers/viewController.js");
scotch.controllers.api = rekuire("controllers/apiController.js");


/* Routes */
scotch.controllers.router.register = function(app){
  app.get("/", function(req, res){
    scotch.controllers.view.render(res, "mainPage");
  });

  app.get("/api/posts", function(req, res){
    function gotPosts(err, data){
      res.json({ "posts": data });
    }

    scotch.controllers.api.getPosts(gotPosts);
  });

  app.get("/api/projects", function(req, res){
    function gotProjects(err, data){
      res.json({ "projects": data });
    }

    scotch.controllers.api.getProjects(gotProjects);
  });
};


module.exports = scotch.controllers.router;
