Scotch
===
*Scotch is a [NodeJS](http://nodejs.org/) website framework created by [Noah Huppert](http://NoahHuppert.com) for his personal site. Scotch can be used under the terms of the [GNU GPL v3.0 License](/LICENSE)*  
*Scotch is designed to be used with a blog and a portfolio as well as some static pages*  

<br>
Table Of Contents
===
[Installation](#installation)  
[Features](#features)  
[Scotch Namespaces](#scotch-namespaces)  
[Scotch Command Line Interface](#scotch-command-line-interface)  
[Directory Structure](#directory-structure)  
[Style Sheets](#style-sheets)  
[Quotes](#quotes)  
[Dependencies](#dependencies)  
[Sass](#using-sass-and-friends)  
[RequireJS](#using-requirejs)

<br>
Installation
===
*To install Scotch use the **Scotch Command Line Interface** *  

**Installation**  
- Clone Scotch to your workspace
 - `git clone https://github.com/Noah-Huppert/Website-2014.git`
- Navigate to the main Scotch directory
 - `cd Scotch`
- Install Grunt locally
 - `npm install`
- Use the **Scotch Command Line Interface** to install Scotch
 - `grunt scotch --install=true`


<br>
Features
===
#####*Model View Controller* design
Scotch's *Model View Controller* design creates a logical code structure. This makes it easier to debug Scotch and write new code for Scotch.

#####Handlebars
Scotch uses [Handlebars Templating](http://handlebarsjs.com/) which is a smarter version of Mustache templating.

#####SCSS flavored Sass
Scotch uses SCSS flavored [Sass](http://sass-lang.com/)

#####Scotch Command Line Interface
Scotch comes with a Command Line Interface. This makes managing the installating of Scotch and updates as simple as running a command. The Scotch Command Line Interface also provides several other tools.

<br>
Scotch Namespaces
===
*Schotch uses namespaces in its code to keep organized, below are a list of these namespaces and a short description*  
- *scotch.cli* - Scotch Command Line Tools
- *scotch.config* - Scotch configuration
- *scotch.controllers* - Scotch controller
 - *scotch.controllers.router* - Scotch page router

<br>
Scotch Command Line Interface
===
*The **Scotch Command Line Interface** makes managing Scotch installation and updating as simple as running a command*

**Commands:**  
> *grunt scotch [**flags**]* => The base command for Scotch-CLI

**Flag Usage:**  
*Scotch Command Line Interface uses flags to determine what action to tag*  
*To use flags simply follow this format:*  

`grunt scotch --{Flag Name}={true/false}`

{Flag Name} - Should be replaced with the flag names, these are listed below
{true/false} - Either write `true` or `false`, `true` would indicate that you want the flag to be active, `false` would indicate that you **do not** want the flag to be active


**Flags:**  
> *--install* => Installs Scotch and its dependencies  
> *--update* => Updates Scotch and its dependencies

<br>
Directory Structure
===
*Once Scotch is properly installed the directory structure should look like this*  
- **bower** => *Bower install dir, see [Dependencies](#dependencies)*  
- **node_modules** => *Where Node installs dependencies*  
- **src** => *Source code*  
 - **server** => *Server side code*  
- **site** => *Actual code for website*
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

*To access dependencies look in `./bower/{Package Name}`(This folder is set in `./.bowerrc`)*  
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
- [GruntJS](http://gruntjs.com/)
- [Rekuire](https://github.com/nadav-dav/rekuire)

<br>
**Other Dependencies**  
*Some dependencies can not be managed through NPM or Bower*  
- [PrismJS](http://prismjs.com/)
 - *src/client/scripts/prism.js*
 - *src/client/styles/css/prism.css*

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
