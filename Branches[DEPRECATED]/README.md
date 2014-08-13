Folder Naming
===
- Name with a singular name
 - Unless it makes no sense to do so
 - **EX:** dependencies => dep !=> deps

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

<br>
Using *Sass and friends*
===
*To have `Sass` compile and watch the project run*  
```
sass --watch public/style/scss:public/style/css
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
