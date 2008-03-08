//
//  CXMLDocument
//  Test
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLDocument.h"

#include <libxml/parser.h>

#import "CXMLNode_PrivateExtensions.h"
#import "CXMLElement.h"

@implementation CXMLDocument

- (id)initWithData:(NSData *)inData options:(NSUInteger)inOptions error:(NSError **)outError
{
if ((self = [super init]) != NULL)
	{
	xmlDocPtr theDoc = xmlParseMemory([inData bytes], [inData length]);
	
	if (theDoc != NULL)
		{
		_node = (xmlNodePtr)theDoc;
		_node->_private = self; // Note. NOT retained (TODO think more about _private usage)
		}
	else
		{
		if (outError)
			*outError = [NSError errorWithDomain:@"CXMLErrorDomain" code:1 userInfo:NULL];
		self = NULL;
		}
	}
return(self);
}

- (CXMLElement *)rootElement
{
xmlNodePtr theLibXMLNode = xmlDocGetRootElement((xmlDocPtr)_node);
	
return([CXMLNode nodeWithLibXMLNode:theLibXMLNode]);
}

@end
