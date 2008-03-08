//
//  CXMLNode_PrivateExtensions.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode.h"

@interface CXMLNode (CXMLNode_PrivateExtensions)

- (id)initWithLibXMLNode:(xmlNodePtr)inLibXMLNode;

+ (id)nodeWithLibXMLNode:(xmlNodePtr)inLibXMLNode;

@end
