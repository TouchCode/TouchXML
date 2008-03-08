//
//  CXMLElement.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLElement.h"

#import "CXMLNode_PrivateExtensions.h"

@implementation CXMLElement

- (NSArray *)elementsForName:(NSString *)name
{
NSMutableArray *theElements = [NSMutableArray array];

// TODO -- native xml api?
const xmlChar *theName = (const xmlChar *)[name UTF8String];

xmlNodePtr theCurrentNode = _node->children;
while (theCurrentNode != NULL)
	{
	if (theCurrentNode->type == XML_ELEMENT_NODE && xmlStrcmp(theName, theCurrentNode->name) == 0)
		{
		CXMLNode *theNode = [CXMLNode nodeWithLibXMLNode:(xmlNodePtr)theCurrentNode];
		[theElements addObject:theNode];
		}
	theCurrentNode = theCurrentNode->next;
	}
return(theElements);
}

//- (NSArray *)elementsForLocalName:(NSString *)localName URI:(NSString *)URI;

- (NSArray *)attributes
{
NSMutableArray *theAttributes = [NSMutableArray array];
xmlAttrPtr theCurrentNode = _node->properties;
while (theCurrentNode != NULL)
	{
	CXMLNode *theAttribute = [CXMLNode nodeWithLibXMLNode:(xmlNodePtr)theCurrentNode];
	[theAttributes addObject:theAttribute];
	theCurrentNode = theCurrentNode->next;
	}
return(theAttributes);
}

- (CXMLNode *)attributeForName:(NSString *)name
{
// TODO -- look for native libxml2 function for finding a named attribute (like xmlGetProp)
const xmlChar *theName = (const xmlChar *)[name UTF8String];

xmlAttrPtr theCurrentNode = _node->properties;
while (theCurrentNode != NULL)
	{
	if (xmlStrcmp(theName, theCurrentNode->name) == 0)
		{
		CXMLNode *theAttribute = [CXMLNode nodeWithLibXMLNode:(xmlNodePtr)theCurrentNode];
		return(theAttribute);
		}
	theCurrentNode = theCurrentNode->next;
	}
return(NULL);
}

//- (CXMLNode *)attributeForLocalName:(NSString *)localName URI:(NSString *)URI;

//- (NSArray *)namespaces; //primitive
//- (CXMLNode *)namespaceForPrefix:(NSString *)name;
//- (CXMLNode *)resolveNamespaceForName:(NSString *)name;
//- (NSString *)resolvePrefixForNamespaceURI:(NSString *)namespaceURI;


@end
