//
//  CXMLDocument.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode.h"

#include <libxml/parser.h>

@class CXMLElement;

// NSXMLDocument
@interface CXMLDocument : CXMLNode {
}

- (id)initWithData:(NSData *)inData options:(NSUInteger)inOptions error:(NSError **)outError;

- (CXMLElement *)rootElement;

@end
