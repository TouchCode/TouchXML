//
//  CXMLDocument_CreationExtensions.m
//  TouchXML
//
//  Created by Jonathan Wight on 11/11/08.
//  Copyright 2008 toxicsoftware.com. All rights reserved.
//

#import "CXMLDocument_CreationExtensions.h"

#import "CXMLElement.h"
#import "CXMLNode_PrivateExtensions.h"

@implementation CXMLDocument (CXMLDocument_CreationExtensions)

- (void)addNamespace:(CXMLNode *)inNamespace
{

xmlSetNs(self->_node, (xmlNsPtr)inNamespace->_node);

}

@end
