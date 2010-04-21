(Originally from [http://foobarpig.com/iphone/touchxml-installation-guide.html][1], reused with kind permission of author.)

# TouchXML installation guide

TouchXML is a libxml API wrapper written in Objective-C and usually helps with all your project XML needs. While writing my post about parsing XML element attributes and putting up demo project I realized that I tend to forget how to add TouchXML to new project, so here goes step-by-step of that procedure:

1. Get TouchXML

	You can find archives to download in touchcode project downloads . Download TouchXML archive and extract it anywhere you like. It’s common practice to keep such libraries and classes in *Developer/ExtraLibs* directory.

2. Enable *libxml2* library

	First things first, before we actually add TouchXML files, we need to do some project configuration changes, so our project could use libxml library.

	1. Go to “Project -> Edit project settings”

	2. Activate “Build” tab

	3. Search for “Header search paths” setting and add */usr/include/libxml2* value to it

		![Image One][IMAGE_1]

	4. Search for “Other linker flags” setting and add *-lxml2* value

		![Image Two][IMAGE_2]

		P.s. notice that search function is really useful for finding settings you need faster.

3. Add TouchXML classes

	1. Right click (option click) on your projects “Classes” folder and go to “Add -> Existing files…”

		![Image Three][IMAGE_3]

	2. Navigate to the directory where extracted TouchXML is kept and browse  deeper to “Common -> Source”. Select everything! And click “Add” obviously.

		![Image Four][IMAGE_4]

	3. Confirm.

		![Image Five][IMAGE_5]

	Now you should see a bunch of new files in your project. I usually group them by selecting files I wish to group and then selecting “Group” in context (right click/option click) menu.

4. Import TouchXML to your project

		#import "TouchXML.h"

	That is all the “magic” and you’re good to go. Since, I am not going to write about actually using TouchXML, you can see a nice working example in my [previous post][2].

5. Common errors

		Error: libxml/tree.h: No such file or directory

	… and hundreds of something missing errors. It means that something went wrong with “Header search paths”. Maybe you didn’t added */usr/include/libxml2* or added incorrectly? Check it.

		Error: “_xmlDocDumpFormatMemory”, referenced from:- [CXMLDocument description] in CXMLDocument.o

	… and tens of errors like this. While errors by them selfs aren’t very expressive, they wish to inform you, that you did not added *-lxml2* flag to “Other linker flags”

And that is all for now!

[1]: http://foobarpig.com/iphone/touchxml-installation-guide.html
[2]: http://foobarpig.com/iphone/parsing-xml-element-attributes-with-touchxml.html
[IMAGE_1]: 1-header-search-paths.png
[IMAGE_2]: 2-other-linker-flags.png
[IMAGE_3]: 3-add-existing-files.png
[IMAGE_4]: 4-select-everything.png
[IMAGE_5]: 5-confirm.png
