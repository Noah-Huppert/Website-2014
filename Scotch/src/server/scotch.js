/* Setup namespace */
var scotch = {};
scotch.core = {};
scotch.controllers = {};


/* Require */
var express = require("express");
var app = express();
var handlebars = require("express3-handlebars");


/* Setup better require */
global.rekuire = require('rekuire');
scotch.controllers.handlebars = rekuire("controllers/handlebarsController.js");


/* Setup Express */
app.set("views", "./src/client/views");

app.engine("handlebars", handlebars({
  extname:"handlebars",
  partialsDir: "./src/client/views/partials",
  layoutsDir: "./src/client/views/layouts",
  defaultLayout: "main",
  helpers: scotch.controllers.handlebars.helpers
}));
app.set("view engine", "hbs");

app.use("/bower", express.static("./bower"));
app.use("/src/client", express.static("./src/client"));


/* Require */
scotch.controllers.log = rekuire("controllers/logController.js");
scotch.controllers.route = rekuire("controllers/routeController.js");


/* Config Routes */
scotch.controllers.route.register(app);


/* Start server */
app.listen(3000, function(){
  scotch.controllers.log.write("Server Listening on port 3000", "scotch.core.app.listen");
});
