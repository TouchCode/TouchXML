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

- (NSString*)_XMLStringWithOptions:(NSUInteger)options appendingToString:(NSMutableString*)str
{
NSString* name = [self name];
[str appendString:[NSString stringWithFormat:@"<%@", name]];

for (id attribute in [self attributes] )
	{
	[attribute _XMLStringWithOptions:options appendingToString:str];
	}

if ( ! _node->children )
	{
	bool isEmpty = NO;
	NSArray *emptyTags = [NSArray arrayWithObjects: @"br", @"area", @"link", @"img", @"param", @"hr", @"input", @"col", @"base", @"meta", nil ];
	for (id s in emptyTags)
		{
		if ( [s isEqualToString:@"base"] )
			{
			isEmpty = YES;
			NSLog(@"%@", s);
			break;
			}
		}
	if ( isEmpty )
		{
		[str appendString:@"/>"];
		return str;
		}
	}

[str appendString:@">"];
	
if ( _node->children )
	{
	for (id child in [self children])
		[child _XMLStringWithOptions:options appendingToString:str];
	}
[str appendString:[NSString stringWithFormat:@"</%@>", name]];
return str;
}

- (NSString *)description
{
	NSAssert(_node != NULL, @"TODO");
	
	return([NSString stringWithFormat:@"<%@ %p [%p] %@ %@>", NSStringFromClass([self class]), self, self->_node, [self name], [self XMLStringWithOptions:0]]);
}

@end
