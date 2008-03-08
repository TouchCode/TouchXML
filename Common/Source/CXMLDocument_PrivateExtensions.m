//
//  CXMLDocument_PrivateExtensions.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CXMLDocument_PrivateExtensions.h"

@implementation CXMLDocument (CXMLDocument_PrivateExtensions)

/*
- (id)initWithLibXmlParserContext:(xmlParserCtxtPtr)inContext options:(NSUInteger)inOptions error:(NSError **)outError
{

xmlParseDocument(inContext);

}
*/

- (NSMutableSet *)nodePool
{
if (nodePool == NULL)
	{
	nodePool = [[NSMutableSet alloc] init];
	}
return(nodePool);
}


@end
