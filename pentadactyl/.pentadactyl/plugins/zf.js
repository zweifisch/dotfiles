(function() {
  "use strict";
  var app, helpers, res;

  helpers = {
    inject: function(url) {
      var document, scriptTag;
      document = content.document;
      scriptTag = document.createElement('script');
      scriptTag.setAttribute('src', url);
      return document.body.appendChild(scriptTag);
    },
    clearStyle: function() {
      var document, i, j, len, len1, link, ref, ref1, ref2, ref3, results, style;
      document = content.document;
      ref = document.getElementsByTagName('style');
      for (i = 0, len = ref.length; i < len; i++) {
        style = ref[i];
        if (style != null) {
          if ((ref1 = style.parentNode) != null) {
            ref1.removeChild(style);
          }
        }
      }
      ref2 = document.getElementsByTagName('link');
      results = [];
      for (j = 0, len1 = ref2.length; j < len1; j++) {
        link = ref2[j];
        results.push(link != null ? (ref3 = link.parentNode) != null ? ref3.removeChild(link) : void 0 : void 0);
      }
      return results;
    },
    removeScript: function() {
      var document, i, len, ref, ref1, results, script;
      document = content.document;
      ref = document.getElementsByTagName('script');
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        script = ref[i];
        results.push((ref1 = script.parentNode) != null ? ref1.removeChild(script) : void 0);
      }
      return results;
    },
    requireCSS: function(style) {
      var document, head, styleTag;
      document = content.document;
      head = document.getElementsByTagName('head')[0];
      styleTag = document.createElement('style');
      styleTag.appendChild(document.createTextNode(style));
      return head.appendChild(styleTag);
    }
  };

  app = {
    version: '0.1',
    urls: function() {
      var browser, tab, tabs;
      browser = gBrowser;
      tabs = (function() {
        var i, len, ref, results;
        ref = browser.mTabContainer.childNodes;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          tab = ref[i];
          results.push(browser.getBrowserForTab(tab).contentDocument);
        }
        return results;
      })();
      return dactyl.clipboardWrite(((function() {
        var i, len, results;
        results = [];
        for (i = 0, len = tabs.length; i < len; i++) {
          tab = tabs[i];
          if (tab.location !== 'about:blank') {
            results.push(tab.location + " " + tab.title);
          }
        }
        return results;
      })()).join("\n"), true);
    },
    org: function() {
      var tab, tabs;
      tabs = (function() {
        var i, len, ref, results;
        ref = gBrowser.mTabContainer.childNodes;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          tab = ref[i];
          results.push(gBrowser.getBrowserForTab(tab).contentDocument);
        }
        return results;
      })();
      return dactyl.clipboardWrite(((function() {
        var i, len, results;
        results = [];
        for (i = 0, len = tabs.length; i < len; i++) {
          tab = tabs[i];
          if (tab.location !== 'about:blank') {
            results.push("[[" + tab.location + "][" + (tab.title ? tab.title : tab.location) + "]]");
          }
        }
        return results;
      })()).join("\n"), true);
    },
    whatFont: function() {
      return helpers.inject('http://chengyinliu.com/wf.js');
    },
    toggleVisualEvent: function() {
      var document;
      if (typeof VisualEvent !== "undefined" && VisualEvent !== null) {
        document = content.document;
        if (document.getElementsById('Event_display')) {
          return VisualEvent.fnClose();
        } else {
          return VisualEvent.fnInit();
        }
      } else {
        return helpers.inject('http://www.sprymedia.co.uk/design/event/media/js/event-loader.js');
      }
    },
    readability: function() {
      helpers.clearStyle();
      return helpers.requireCSS(res.markdown);
    },
    solarized: function() {
      var i, j, k, len, len1, len2, ref, ref1, ref2, ref3, t, tag;
      helpers.clearStyle();
      ref = ['iframe', 'embed', 'object'];
      for (i = 0, len = ref.length; i < len; i++) {
        tag = ref[i];
        ref1 = document.getElementsByTagName(tag);
        for (j = 0, len1 = ref1.length; j < len1; j++) {
          t = ref1[j];
          if (t != null) {
            if ((ref2 = t.parentNode) != null) {
              ref2.removeChild(t);
            }
          }
        }
      }
      ref3 = document.getElementsByTagName('*');
      for (k = 0, len2 = ref3.length; k < len2; k++) {
        tag = ref3[k];
        if (tag != null) {
          tag.removeAttribute('style');
        }
      }
      return helpers.requireCSS(res.solarized);
    },
    jquery: function() {
      return helpers.inject('http://code.jquery.com/jquery-1.10.2.min.js');
    }
  };

  group.commands.add(['whatfont', 'wf'], "what font", app.whatFont);

  group.commands.add(['freeze'], "export urls", app.urls);

  group.commands.add(['tabs2org'], "export urls for org-mode", app.org);

  group.commands.add(['visualevent'], "visual event", app.toggleVisualEvent);

  group.commands.add(['readability'], "improve readability", app.readability);

  group.commands.add(['solarized'], "solarized", app.solarized);

  group.commands.add(['jquery', 'jq'], "inject jquery", app.jquery);

  res = {};

  res.markdown = "body{\n    margin: 0 auto;\n    font-family: Georgia, Palatino, serif;\n    color: #444444;\n    line-height: 1;\n    max-width: 960px;\n    padding: 30px;\n}\nh1, h2, h3, h4 {\n    color: #111111;\n    font-weight: 400;\n}\nh1, h2, h3, h4, h5, p {\n    margin-bottom: 24px;\n    padding: 0;\n}\nh1 {\n    font-size: 48px;\n}\nh2 {\n    font-size: 36px;\n    margin: 24px 0 6px;\n}\nh3 {\n    font-size: 24px;\n}\nh4 {\n    font-size: 21px;\n}\nh5 {\n    font-size: 18px;\n}\na {\n    color: #0099ff;\n    margin: 0;\n    padding: 0;\n    vertical-align: baseline;\n}\na:hover {\n    text-decoration: none;\n    color: #ff6600;\n}\na:visited {\n    color: purple;\n}\nul, ol {\n    padding: 0;\n    margin: 0;\n}\nli {\n    line-height: 24px;\n}\nli ul, li ul {\n    margin-left: 24px;\n}\np, ul, ol {\n    font-size: 16px;\n    line-height: 24px;\n    max-width: 540px;\n}\npre {\n    padding: 0px 24px;\n    max-width: 800px;\n    white-space: pre-wrap;\n}\ncode {\n    font-family: Consolas, Monaco, Andale Mono, monospace;\n    line-height: 1.5;\n    font-size: 13px;\n}\naside {\n    display: block;\n    float: right;\n    width: 390px;\n}\nblockquote {\n    border-left:.5em solid #eee;\n    padding: 0 2em;\n    margin-left:0;\n    max-width: 476px;\n}\nblockquote  cite {\n    font-size:14px;\n    line-height:20px;\n    color:#bfbfbf;\n}\nblockquote cite:before {\n    content: '\\2014 \\00A0';\n}\n\nblockquote p {  \n    color: #666;\n    max-width: 460px;\n}\nhr {\n    width: 540px;\n    text-align: left;\n    margin: 0 auto 0 0;\n    color: #999;\n}\n\n/* Code below this line is copyright Twitter Inc. */\n\nbutton,\ninput,\nselect,\ntextarea {\n  font-size: 100%;\n  margin: 0;\n  vertical-align: baseline;\n  *vertical-align: middle;\n}\nbutton, input {\n  line-height: normal;\n  *overflow: visible;\n}\nbutton::-moz-focus-inner, input::-moz-focus-inner {\n  border: 0;\n  padding: 0;\n}\nbutton,\ninput[type=\"button\"],\ninput[type=\"reset\"],\ninput[type=\"submit\"] {\n  cursor: pointer;\n  -webkit-appearance: button;\n}\ninput[type=checkbox], input[type=radio] {\n  cursor: pointer;\n}\n/* override default chrome & firefox settings */\ninput:not([type=\"image\"]), textarea {\n  -webkit-box-sizing: content-box;\n  -moz-box-sizing: content-box;\n  box-sizing: content-box;\n}\n\ninput[type=\"search\"] {\n  -webkit-appearance: textfield;\n  -webkit-box-sizing: content-box;\n  -moz-box-sizing: content-box;\n  box-sizing: content-box;\n}\ninput[type=\"search\"]::-webkit-search-decoration {\n  -webkit-appearance: none;\n}\nlabel,\ninput,\nselect,\ntextarea {\n  font-family: \"Helvetica Neue\", Helvetica, Arial, sans-serif;\n  font-size: 13px;\n  font-weight: normal;\n  line-height: normal;\n  margin-bottom: 18px;\n}\ninput[type=checkbox], input[type=radio] {\n  cursor: pointer;\n  margin-bottom: 0;\n}\ninput[type=text],\ninput[type=password],\ntextarea,\nselect {\n  display: inline-block;\n  width: 210px;\n  padding: 4px;\n  font-size: 13px;\n  font-weight: normal;\n  line-height: 18px;\n  height: 18px;\n  color: #808080;\n  border: 1px solid #ccc;\n  -webkit-border-radius: 3px;\n  -moz-border-radius: 3px;\n  border-radius: 3px;\n}\nselect, input[type=file] {\n  height: 27px;\n  line-height: 27px;\n}\ntextarea {\n  height: auto;\n}\n\n/* grey out placeholders */\n:-moz-placeholder {\n  color: #bfbfbf;\n}\n::-webkit-input-placeholder {\n  color: #bfbfbf;\n}\n\ninput[type=text],\ninput[type=password],\nselect,\ntextarea {\n  -webkit-transition: border linear 0.2s, box-shadow linear 0.2s;\n  -moz-transition: border linear 0.2s, box-shadow linear 0.2s;\n  transition: border linear 0.2s, box-shadow linear 0.2s;\n  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);\n  -moz-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);\n  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);\n}\ninput[type=text]:focus, input[type=password]:focus, textarea:focus {\n  outline: none;\n  border-color: rgba(82, 168, 236, 0.8);\n  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);\n  -moz-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);\n  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);\n}\n\n/* buttons */\nbutton {\n  display: inline-block;\n  padding: 4px 14px;\n  font-family: \"Helvetica Neue\", Helvetica, Arial, sans-serif;\n  font-size: 13px;\n  line-height: 18px;\n  -webkit-border-radius: 4px;\n  -moz-border-radius: 4px;\n  border-radius: 4px;\n  -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);\n  -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);\n  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05);\n  background-color: #0064cd;\n  background-repeat: repeat-x;\n  background-image: -khtml-gradient(linear, left top, left bottom, from(#049cdb), to(#0064cd));\n  background-image: -moz-linear-gradient(top, #049cdb, #0064cd);\n  background-image: -ms-linear-gradient(top, #049cdb, #0064cd);\n  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #049cdb), color-stop(100%, #0064cd));\n  background-image: -webkit-linear-gradient(top, #049cdb, #0064cd);\n  background-image: -o-linear-gradient(top, #049cdb, #0064cd);\n  background-image: linear-gradient(top, #049cdb, #0064cd);\n  color: #fff;\n  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);\n  border: 1px solid #004b9a;\n  border-bottom-color: #003f81;\n  -webkit-transition: 0.1s linear all;\n  -moz-transition: 0.1s linear all;\n  transition: 0.1s linear all;\n  border-color: #0064cd #0064cd #003f81;\n  border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);\n}\nbutton:hover {\n  color: #fff;\n  background-position: 0 -15px;\n  text-decoration: none;\n}\nbutton:active {\n  -webkit-box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);\n  -moz-box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);\n  box-shadow: inset 0 3px 7px rgba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);\n}\nbutton::-moz-focus-inner {\n  padding: 0;\n  border: 0;\n}";

  res.dark = "* {\n  background: #232323;\n  border-color: #1a1a1a;\n  color: #797979;\n  text-shadow: 0px 1px 1px #000;\n}\n*::selection {\n  background: #c00;\n  colo: r #fff;\n}\nh1,\nh2,\nh3,\nh4,\nh5 {\n  color: #626262;\n  text-shadow: 0px 1px 0 #000;\n}\nh1,\nh2 {\n  text-shadow: 0px 2px 2px #000;\n}\na {\n  color: #07c;\n  font-weight: normal;\n  text-decoration: none;\n  text-shadow: 0 1px 1px #000;\n}\nb {\n  font-weight: normal;\n}\nimg {\n  -moz-opacity: 0.1;\n  background: #232323;\n  box-shadow: inset 0 0 10px #000;\n}\nhr {\n  color: #1a1a1a;\n  background-color: #1a1a1a;\n  height: 1px;\n}\ntable {\n  border-collapse: collapse;\n}\ninput {\n  border: 1px solid #232323;\n  box-shadow: inset 0 0 4px #000;\n  color: #000;\n  text-shadow: 0px 1px 1px #333;\n}\ntextarea {\n  border: 1px solid #232323;\n  box-shadow: inset 0 0 4px #000;\n  color: #000;\n  text-shadow: 0px 1px 1px #333;\n}\ninput:submit {\n  border: 1px solid #232323;\n  box-shadow: 0 0px 1px #000;\n  color: #000;\n  text-shadow: 0px 1px 1px #333;\n}";

  res.solarized = "* {\n  background: #002b36;\n  border-color: #1a1a1a;\n  color: #93A1A1;\n  text-shadow: 0px 1px 1px #000;\n}\n*::selection {\n  background: #c00;\n  colo: r #fff;\n}\nh1,\nh2,\nh3,\nh4,\nh5 {\n  color: #93A1A1;\n  text-shadow: 0px 1px 0 #000;\n}\nh1,\nh2 {\n  text-shadow: 0px 2px 2px #000;\n}\na {\n  color: #07c;\n  font-weight: normal;\n  text-decoration: none;\n  text-shadow: 0 1px 1px #000;\n}\nb {\n  font-weight: normal;\n}\nimg {\n  -moz-opacity: 0.1;\n  background: #002b36;\n  box-shadow: inset 0 0 10px #000;\n}\nhr {\n  color: #93A1A1;\n  background-color: #1a1a1a;\n  height: 1px;\n}\ntable {\n  border-collapse: collapse;\n}\ninput {\n  border: 1px solid #002b36;\n  box-shadow: inset 0 0 4px #000;\n  color: #93A1A1;\n  text-shadow: 0px 1px 1px #333;\n}\ntextarea {\n  border: 1px solid #002b36;\n  box-shadow: inset 0 0 4px #000;\n  color: #93A1A1;\n  text-shadow: 0px 1px 1px #333;\n}\ninput:submit {\n  border: 1px solid #002b36;\n  box-shadow: 0 0px 1px #000;\n  color: #93A1A1;\n  text-shadow: 0px 1px 1px #333;\n}";

  "*{\n    font-family:Bitter, Georgia, sans-serif;\n}";

}).call(this);
