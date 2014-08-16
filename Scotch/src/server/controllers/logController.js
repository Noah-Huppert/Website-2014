/* Scotch namespace */
scotch = {};
scotch.controllers = {};

scotch.controllers.log = {};


/* Actions */
scotch.controllers.log.write = function(message, location, category){
  if(category === undefined){
    category = "General";
  }

  console.log("Scotch - " + location + ": " + message);
};

scotch.controllers.log.error = function(error, location){
  scotch.controllers.log.write(error, location, "Error");
};


module.exports = scotch.controllers.log;
