Scotch
===
*^ Replace with logo ^*  
*Scotch is a [NodeJS](http://nodejs.org/) website framework created by [Noah Huppert](http://NoahHuppert.com) for his personal site. Scotch can be used under the terms of the [GNU GPL v3.0 License](/LICENSE)*  
*Scotch is designed to be used with a blog and a portfolio as well as some static pages*  

<br>
Table Of Contents
===
[Features](#Features)  
[Directory Structure](#Directory_Structure)  
[Style Sheets](#Style_Sheets)  
[Quotes](#Quotes)  
[Dependencies](#Dependencies)  
[Sass](#Using_Sass_and_friends)  
[RequireJS](#Using_RequireJS)

<br>
Features
===
#####*Model View Controller* design
Scotch's *Model View Controller* design creates a logical code structure. This makes it easier to debug Scotch and write new code for Scotch.

#####Handlebars
Scotch uses [Handlebars Templating](http://handlebarsjs.com/) which is a smarter version of Mustache templating.

#####SCSS flavored Sass
Scotch uses SCSS flavored [Sass](http://sass-lang.com/)


<br>
Directory Structure
===
*Once Scotch is properly installed the directory structure should look like this*  
- **lib** => *Bower install dir, see [Dependencies](#Dependencies)*
- **src** => *Source code*  
 - **server** => *Server side code*  
   - **controllers** => *Server controllers*
   - **models** => *Server models*
 - **client** => *Client side code*
   - **views** => *Template and view files*
     - **layouts** => *Layout template files*
   - **styles** => *Style files such as css*
     - **scss** => *Uncompiled SCSS*
     - **css** => *SCSS compiled into css*
   - **scripts** => *Scripts*
     - **javascript** => *Javascript scripts*

<br>
Style Sheets
===
*Always use the file extension `.scss`*  
*Always put this code at the top of all styles*  
```css
@import "include";
```
*This will include a file which will handle importing Bourbon, Neat, and Bitters*

<br>
Quotes
===
*Always use double quotes `""`*  
*If nesting quotes are needed, escape characters instead of using `''`*  
```html
<div foo="bar(\"baz\")"></div>
```

<br>
Dependencies
===
*For dependencies use [bower](http://bower.io/)*  
**Bower Commands:**  
> *bower install* => Installs bower packages  
> *bower update* => Updates bower packages

*To access dependencies look in `./lib/bower/{Package Name}`(This folder is set in `./.bowerrc`)*  
**Current dependencies:**  
- [Bourbon](http://bourbon.io/)
- [Neat](http://neat.bourbon.io/)
- [Bitters](http://bitters.bourbon.io/)
- [Jquery](http://jquery.com/)
- [Modernizr](http://modernizr.com/)
- [RequireJS](http://requirejs.org/)
- [Polymer](http://www.polymer-project.org/)
 - [Polymer Core](http://www.polymer-project.org/)
 - [Polymer Core Elements](http://www.polymer-project.org/docs/elements/core-elements.html)
 - [Polymer Paper Elements](http://www.polymer-project.org/docs/elements/paper-elements.html)
- [Octicons](https://octicons.github.com/)

<br>
*For some dependencies [NPM](http://www.npm.org) is used*  
**NPM Commands:**  
> *npm install* => Installs NPM packages  
> *npm update* => Updates NPM packages

*To access NPM dependencies look in `./lib/node_modules/{Package Name}`*  
- [ExpressJS](http://expressjs.com/)
- [doT](http://olado.github.io/doT/)

<br>
Using *Sass and friends*
===
*To have `Sass` compile and watch the project run*  
```
sass --watch src:public/style/css
```  
*Or run `start.bat`*

<br>
Using *RequireJS*
===
*At the top of any html file that you wish to use javascript in add this before including any more files*  
```html
<script data-main="{Javascript Path}/app.js" src="{Bower Path}/requirejs/require.js"></script>
```

<br>
*Using this template will make the overall JS namespace more orginized*  
*In any page specific JS use this template:*  
```javascript
  /* Define page specific namespace */
  self.page.{Page Name} = {}
```  
*`self.page` is already defined in `app.js`*  
