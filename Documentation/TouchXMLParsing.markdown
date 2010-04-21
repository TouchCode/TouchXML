(Originally from [http://foobarpig.com/iphone/parsing-xml-element-attributes-with-touchxml.html][1], reused with kind permission of author.)

Parsing XML element attributes with TouchXML
Assuming that you already familiar with parsing XML with a little help from TouchXML we will go straight to the topic: parsing an attribute! I’ll just put some “sample” XML here so it would be easier to understand what’s happening in code later.

	<pigletlist>
	<piglet id="1">
		<name>Nifnif</name>
	</piglet>
	<piglet id="2">
		<name>Nufnuf</name>
	</piglet>
	<piglet id="3">
		<name>Nafnaf</name>
	</piglet>
	</pigletlist>

Well, here we have our tree little piglets put in a single XML file and bellow lies the magic code which parses piglet list with their id attributes. If you are too lazy to look trough all the code (I would be), key point is attributeForName method of CXMLElement object used like this: [[node attributeForName:@"id"] stringValue].

	//  we will put parsed data in an a array
	NSMutableArray *res = [[NSMutableArray alloc] init];

	//  using local resource file
	 NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"piglets.xml"];
	NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
	  CXMLDocument *doc = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];

	NSArray *nodes = NULL;
	//  searching for piglet nodes
	nodes = [doc nodesForXPath:@"//piglet" error:nil];

	for (CXMLElement *node in nodes) {
	  NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
	  int counter;
	  for(counter = 0; counter < [node childCount]; counter++) {
		//  common procedure: dictionary with keys/values from XML node
		[item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] name]];
	  }

	  //  and here it is - attributeForName! Simple as that.
	  [item setObject:[[node attributeForName:@"id"] stringValue] forKey:@"id"];  // <------ this magical arrow is pointing to the area of interest

	  [res addObject:item];
	  [item release];
	}

	//  and we print our results
	NSLog(@"%@", res);
	[res release];

Our results:

	2010-02-05 09:54:01.078 demo[1901:207] (
			{
			id = 1;
			name = Nifnif;
		},
			{
			id = 2;
			name = Nufnuf;
		},
			{
			id = 3;
			name = Nafnaf;
		}
	)

[1]: http://foobarpig.com/iphone/parsing-xml-element-attributes-with-touchxml.html
