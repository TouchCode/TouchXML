//
//  CXMLNode_PrivateExtensions.m
//  Test
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode_PrivateExtensions.h"

#import "CXMLElement.h"

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

CXMLNode *theNode = NULL;
switch (inLibXMLNode->type)
	{
	case XML_ELEMENT_NODE:
		{
		theNode = [[[CXMLElement alloc] initWithLibXMLNode:inLibXMLNode] autorelease];
		}
		break;
	case XML_ATTRIBUTE_NODE:
		{
		theNode = [[[CXMLNode alloc] initWithLibXMLNode:inLibXMLNode] autorelease];
		}
		break;
	case XML_TEXT_NODE:
		{
		theNode = [[[CXMLNode alloc] initWithLibXMLNode:inLibXMLNode] autorelease];
		}
		break;
	default:
		NSAssert1(NO, @"TODO Unhandled type (%d).", inLibXMLNode->type);
		return(NULL);
	}
	
theNode->_node->_private = [theNode retain]; // TODO think more about potention retain cycles
return(theNode);
}

@end
