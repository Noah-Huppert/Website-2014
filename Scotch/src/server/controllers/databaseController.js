/* Setup namespace */
var scotch = {};
scotch.controllers = {};
scotch.config = {};

scotch.controllers.database = {};

/* Scotch require */
scotch.config.credentials = rekuire("config/credentials.js");
scotch.controllers.log = rekuire("controllers/logController.js");


/* Require */
var mongodb = require("mongodb");

scotch.controllers.database.use = function(callback){
  function connectedToDatabase(err, db){
    if(!!err){
      scotch.controllers.log.error("scotch.controllers.database.use - " + err);
    }

    callback(err, db);
  }

  mongodb.connect(scotch.config.credentials.assembleDatabaseUrl(), connectedToDatabase);
};

scotch.controllers.database.collection = function(collectionName, callback){
  function connectedToDatabase(err, db){
    var collection = db.collection(collectionName);

    callback(err, collection);
  }

  scotch.controllers.database.use(connectedToDatabase);
};


module.exports = scotch.controllers.database;
