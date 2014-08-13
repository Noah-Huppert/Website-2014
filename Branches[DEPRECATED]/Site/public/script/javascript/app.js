/*
This file will require all JS dependencies.
Require this file in any other JS files
*/


/* Init namespace */
var self = {};
self.build.require = {};
self.build.bower = {};
self.page = {};


/* Bower */
self.build.bower.build.bowerPath = "../../bower";


/* Require */
self.build.require.config = {
  paths: {
    app: "./app",
    bower: self.build.bower.build.bowerPath
  }
};

self.build.require.dependencies = [
  "bower/jquery/dist/jquery.js",
  "bower/modernizr/modernizr.js"
];

//Setup paths
requirejs.config(self.build.require.config);

//Require dependencies
requirejs(self.build.require.dependencies);
