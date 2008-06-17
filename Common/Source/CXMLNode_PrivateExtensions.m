//
//  CXMLNode_PrivateExtensions.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode_PrivateExtensions.h"

#import "CXMLElement.h"
#import "CXMLDocument_PrivateExtensions.h"

@implementation CXMLNode (CXMLNode_PrivateExtensions)

- (id)initWithLibXMLNode:(xmlNodePtr)inLibXMLNode;
{
if ((self = [super init]) != NULL)
	{
	_node = inLibXMLNode;
	}
return(self);
}

+ (id)nodeWithLibXMLNode:(xmlNodePtr)inLibXMLNode
{
// TODO more checking.
if (inLibXMLNode->_private)
	return(inLibXMLNode->_private);

Class theClass = [CXMLNode class];
switch (inLibXMLNode->type)
	{
	case XML_ELEMENT_NODE:
		theClass = [CXMLElement class];
		break;
	case XML_ATTRIBUTE_NODE:
	case XML_TEXT_NODE:
	case XML_CDATA_SECTION_NODE:
	case XML_COMMENT_NODE:
		break;
	default:
		NSAssert1(NO, @"TODO Unhandled type (%d).", inLibXMLNode->type);
		return(NULL);
	}

CXMLNode *theNode = [[[theClass alloc] initWithLibXMLNode:inLibXMLNode] autorelease];


CXMLDocument *theXMLDocument = inLibXMLNode->doc->_private;
NSAssert(theXMLDocument != NULL, @"TODO");
NSAssert([theXMLDocument isKindOfClass:[CXMLDocument class]] == YES, @"TODO");

[[theXMLDocument nodePool] addObject:theNode];

theNode->_node->_private = theNode;
return(theNode);
}

@end
