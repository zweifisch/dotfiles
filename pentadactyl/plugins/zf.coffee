# zf's scripts for penta
# version: 0.1
# author: zf
# dev tip: search for the keywords..

"use strict"

# Object::first = -> return @[0] if @?[0] 
# first = (object)-> return object[0] if object?[0]
# document.getElementByTagName = (args...)-> document.getElementsByTagName(args...).first()

helpers =
	inject: (url)->
		document = content.document
		scriptTag = document.createElement 'script'
		scriptTag.setAttribute 'src', url
		document.body.appendChild scriptTag
	clearStyle : ->
		document = content.document
		for style in document.getElementsByTagName('style') then style?.parentNode?.removeChild style
		for link in document.getElementsByTagName('link') then link?.parentNode?.removeChild link
	removeScript : -> 
		document = content.document
		for script in document.getElementsByTagName 'script' then script.parentNode?.removeChild script
	requireCSS : (style)->
		document = content.document
		head = document.getElementsByTagName('head')[0]
		styleTag = document.createElement 'style'
		styleTag.appendChild document.createTextNode style
		head.appendChild styleTag

app =
	version: '0.1'
	urls: ->
		browser = gBrowser
		tabs = (browser.getBrowserForTab(tab).contentDocument for tab in browser.mTabContainer.childNodes)
		dactyl.clipboardWrite ("#{tab.location} #{tab.title}" for tab in tabs when tab.location isnt 'about:blank').join("\n"),true
	whatFont:->
		helpers.inject 'http://chengyinliu.com/wf.js'
	toggleVisualEvent: ->
		if VisualEvent?
			document = content.document
			if document.getElementsById 'Event_display'
				VisualEvent.fnClose()
			else
				VisualEvent.fnInit()
		else
			helpers.inject 'http://www.sprymedia.co.uk/design/event/media/js/event-loader.js'
	readability: ->
		helpers.clearStyle()
		helpers.requireCSS(res.markdown)
	solarized: ->
		helpers.clearStyle()
		for tag in ['iframe','embed','object']
			for t in document.getElementsByTagName tag then t?.parentNode?.removeChild t
		for tag in document.getElementsByTagName '*' then tag.removeAttribute 'style'
		helpers.requireCSS(res.solarized)
	fun: ->
		for tag in document.getElementsByTagName '*' then tag?.parentNode?.removeChild tag
	jquery: ->
		helpers.inject 'http://code.jquery.com/jquery-1.10.2.min.js'

group.commands.add ['whatfont', 'wf'], "what font", app.whatFont
group.commands.add ['freeze'], "export urls", app.urls
group.commands.add ['visualevent'], "visual event", app.toggleVisualEvent
group.commands.add ['readability'], "improve readability", app.readability
group.commands.add ['solarized'], "solarized", app.solarized
group.commands.add ['jquery', 'jq'], "inject jquery", app.jquery
group.commands.add ['hack'], "hack", app.hack


res = {}
res.markdown = """
body{
    margin: 0 auto;
    font-family: Georgia, Palatino, serif;
    color: #444444;
    line-height: 1;
    max-width: 960px;
    padding: 30px;
}
h1, h2, h3, h4 {
    color: #111111;
    font-weight: 400;
}
h1, h2, h3, h4, h5, p {
    margin-bottom: 24px;
    padding: 0;
}
h1 {
    font-size: 48px;
}
h2 {
    font-size: 36px;
    margin: 24px 0 6px;
}
h3 {
    font-size: 24px;
}
h4 {
    font-size: 21px;
}
h5 {
    font-size: 18px;
}
a {
    color: #0099ff;
    margin: 0;
    padding: 0;
    vertical-align: baseline;
}
a:hover {
    text-decoration: none;
    color: #ff6600;
}
a:visited {
    color: purple;
}
ul, ol {
    padding: 0;
    margin: 0;
}
li {
    line-height: 24px;
}
li ul, li ul {
    margin-left: 24px;
}
p, ul, ol {
    font-size: 16px;
    line-height: 24px;
    max-width: 540px;
}
pre {
    padding: 0px 24px;
    max-width: 800px;
    white-space: pre-wrap;
}
code {
    font-family: Consolas, Monaco, Andale Mono, monospace;
    line-height: 1.5;
    font-size: 13px;
}
aside {
    display: block;
    float: right;
    width: 390px;
}
blockquote {
    border-left:.5em solid #eee;
    padding: 0 2em;
    margin-left:0;
    max-width: 476px;
}
blockquote  cite {
    font-size:14px;
    line-height:20px;
    color:#bfbfbf;
}
blockquote cite:before {
    content: '\\2014 \\00A0';
}

blockquote p {  
    color: #666;
    max-width: 460px;
}
hr {
    width: 540px;
    text-align: left;
    margin: 0 auto 0 0;
    color: #999;
}

/* Code below this line is copyright Twitter Inc. */

button,
input,
select,
textarea {
  font-size: 100%;
  margin: 0;
  vertical-align: baseline;
  *vertical-align: middle;
}
button, input {
  line-height: normal;
  *overflow: visible;
}
button::-moz-focus-inner, input::-moz-focus-inner {
  border: 0;
  padding: 0;
}
button,
input[type="button"],
input[type="reset"],
input[type="submit"] {
  cursor: pointer;
  -webkit-appearance: button;
}
input[type=checkbox], input[type=radio] {
  cursor: pointer;
}
/* override default chrome & firefox settings */
input:not([type="image"]), textarea {
  -webkit-box-sizing: content-box;
  -moz-box-sizing: content-box;
  box-sizing: content-box;
}

input[type="search"] {
  -webkit-appearance: textfield;
  -webkit-box-sizing: content-box;
  -moz-box-sizing: content-box;
  box-sizing: content-box;
}
input[type="search"]::-webkit-search-decoration {
  -webkit-appearance: none;
}
label,
input,
select,
textarea {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  font-weight: normal;
  line-height: normal;
  margin-bottom: 18px;
}
input[type=checkbox], input[type=radio] {
  cursor: pointer;
  margin-bottom: 0;
}
input[type=text],
input[type=password],
textarea,
select {
  display: inline-block;
  width: 210px;
  padding: 4px;
  font-size: 13px;
  font-weight: normal;
  line-height: 18px;
  height: 18px;
  color: #808080;
  border: 1px solid #ccc;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
}
select, input[type=file] {
  height: 27px;
  line-height: 27px;
}
textarea {
  height: auto;
}

/* grey out placeholders */
:-moz-placeholder {
  color: #bfbfbf;
}
::-webkit-input-placeholder {
  color: #bfbfbf;
}

input[type=text],
input[type=password],
select,
textarea {
  -webkit-transition: border linear 0.2s, box-shadow linear 0.2s;
  -moz-transition: border linear 0.2s, box-shadow linear 0.2s;
  transition: border linear 0.2s, box-shadow linear 0.2s;
  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}
input[type=text]:focus, input[type=password]:focus, textarea:focus {
  outline: none;
  border-color: rgba(82, 168, 236, 0.8);
  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
  -moz-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
}

/* buttons */
button {
  display: inline-block;
  padding: 4px 14px;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  line-height: 18px;
  -webkit-border-radius: 4px;
  -moz-border-radius: 4px;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
  -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);
  background-color: #0064cd;
  background-repeat: repeat-x;
  background-image: -khtml-gradient(linear, left top, left bottom, from(#049cdb), to(#0064cd));
  background-image: -moz-linear-gradient(top, #049cdb, #0064cd);
  background-image: -ms-linear-gradient(top, #049cdb, #0064cd);
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #049cdb), color-stop(100%, #0064cd));
  background-image: -webkit-linear-gradient(top, #049cdb, #0064cd);
  background-image: -o-linear-gradient(top, #049cdb, #0064cd);
  background-image: linear-gradient(top, #049cdb, #0064cd);
  color: #fff;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
  border: 1px solid #004b9a;
  border-bottom-color: #003f81;
  -webkit-transition: 0.1s linear all;
  -moz-transition: 0.1s linear all;
  transition: 0.1s linear all;
  border-color: #0064cd #0064cd #003f81;
  border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
}
button:hover {
  color: #fff;
  background-position: 0 -15px;
  text-decoration: none;
}
button:active {
  -webkit-box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);
  -moz-box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);
  box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);
}
button::-moz-focus-inner {
  padding: 0;
  border: 0;
}
"""

res.dark = """
* {
  background: #232323;
  border-color: #1a1a1a;
  color: #797979;
  text-shadow: 0px 1px 1px #000;
}
*::selection {
  background: #c00;
  colo: r #fff;
}
h1,
h2,
h3,
h4,
h5 {
  color: #626262;
  text-shadow: 0px 1px 0 #000;
}
h1,
h2 {
  text-shadow: 0px 2px 2px #000;
}
a {
  color: #07c;
  font-weight: normal;
  text-decoration: none;
  text-shadow: 0 1px 1px #000;
}
b {
  font-weight: normal;
}
img {
  -moz-opacity: 0.1;
  background: #232323;
  box-shadow: inset 0 0 10px #000;
}
hr {
  color: #1a1a1a;
  background-color: #1a1a1a;
  height: 1px;
}
table {
  border-collapse: collapse;
}
input {
  border: 1px solid #232323;
  box-shadow: inset 0 0 4px #000;
  color: #000;
  text-shadow: 0px 1px 1px #333;
}
textarea {
  border: 1px solid #232323;
  box-shadow: inset 0 0 4px #000;
  color: #000;
  text-shadow: 0px 1px 1px #333;
}
input:submit {
  border: 1px solid #232323;
  box-shadow: 0 0px 1px #000;
  color: #000;
  text-shadow: 0px 1px 1px #333;
}
"""

res.solarized = """
* {
  background: #002b36;
  border-color: #1a1a1a;
  color: #93A1A1;
  text-shadow: 0px 1px 1px #000;
}
*::selection {
  background: #c00;
  colo: r #fff;
}
h1,
h2,
h3,
h4,
h5 {
  color: #93A1A1;
  text-shadow: 0px 1px 0 #000;
}
h1,
h2 {
  text-shadow: 0px 2px 2px #000;
}
a {
  color: #07c;
  font-weight: normal;
  text-decoration: none;
  text-shadow: 0 1px 1px #000;
}
b {
  font-weight: normal;
}
img {
  -moz-opacity: 0.1;
  background: #002b36;
  box-shadow: inset 0 0 10px #000;
}
hr {
  color: #93A1A1;
  background-color: #1a1a1a;
  height: 1px;
}
table {
  border-collapse: collapse;
}
input {
  border: 1px solid #002b36;
  box-shadow: inset 0 0 4px #000;
  color: #93A1A1;
  text-shadow: 0px 1px 1px #333;
}
textarea {
  border: 1px solid #002b36;
  box-shadow: inset 0 0 4px #000;
  color: #93A1A1;
  text-shadow: 0px 1px 1px #333;
}
input:submit {
  border: 1px solid #002b36;
  box-shadow: 0 0px 1px #000;
  color: #93A1A1;
  text-shadow: 0px 1px 1px #333;
}
"""
"""
*{
	font-family:Bitter, Georgia, sans-serif;
}
"""
