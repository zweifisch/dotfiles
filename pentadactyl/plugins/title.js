// "use strict";
XML.ignoreWhitespace = false;
XML.prettyPrinting = false;
var INFO =
<plugin name="getitle" version="0.0.1"
        href=""
        summary="Get Title"
        xmlns={NS}>
    <author email="zf.pascal@gmail.com">zf</author>
    <license href="http://opensource.org/licenses/mit-license.php">MIT</license>
    <project name="" min-version="0.1"/>
    <p>
        This plugin provides simply get the title of any web page
    </p>
    <item>
        <tags>:title :tt</tags>
        <strut/>
        <spec>:title</spec>
        <description>
            <p>
                get title copied
            </p>
        </description>
    </item>
</plugin>;

if ("noscriptOverlay" in window)
    noscriptOverlay.safeAllow("dactyl:", true, false);


group.commands.add(["title", "tt"],
    "get title copied",
    function () {
			commands.get("title").action();
    },
    { argCount: "0" }, true);
