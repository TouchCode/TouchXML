//
//  CXMLDocument_PrivateExtensions.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CXMLDocument.h"

#include <libxml/parser.h>

@interface CXMLDocument (CXMLDocument_PrivateExtensions)

//- (id)initWithLibXmlParserContext:(xmlParserCtxtPtr)inContext options:(NSUInteger)inOptions error:(NSError **)outError;

- (NSMutableSet *)nodePool;

@end
