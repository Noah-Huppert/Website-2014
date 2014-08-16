/* Setup namespace */
var scotch = {};
scotch.core = {};
scotch.controllers = {};


/* Require */
var express = require("express");
var app = express();
var expressHbs = require("express3-handlebars");


app.set("views", __dirname + "/../client/views");

app.engine("hbs", expressHbs({extname:"html.hbs", defaultLayout: "../../src/client/views/layouts/main"}));
app.set("view engine", "hbs");

app.use(express.static(__dirname + "/../../"));

scotch.controllers.log = require(__dirname + "/controllers/logController.js");
scotch.controllers.route = require(__dirname + "/controllers/routeController.js");


scotch.controllers.route.register(app);


app.listen(3000, function(){
  scotch.controllers.log.write("Server Listening on port 3000", "scotch.core.app.listen");
});
