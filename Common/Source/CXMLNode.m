//
//  CXMLNode.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode.h"

#import "CXMLNode_PrivateExtensions.h"
#import "CXMLDocument.h"

#include <libxml/xpath.h>

@implementation CXMLNode

- (void)dealloc
{
if (_node)
	{
	_node->_private = NULL;
	_node = NULL;
	}
//
[super dealloc];
}

- (CXMLNodeKind)kind
{
NSAssert(_node != NULL, @"TODO");
return(_node->type); // TODO this isn't 100% accurate!
}

- (NSString *)name
{
NSAssert(_node != NULL, @"TODO");
// TODO use xmlCheckUTF8 to check name
if (_node->name == NULL)
	return(NULL);
else
	return([NSString stringWithUTF8String:(const char *)_node->name]);
}

- (NSString *)stringValue
{
NSAssert(_node != NULL, @"TODO");

xmlChar *theXMLString = xmlNodeListGetString(_node->doc, _node->children, YES);

NSString *theStringValue = NULL;
if (theXMLString != NULL)
	{
	theStringValue = [NSString stringWithUTF8String:(const char *)theXMLString];
	xmlFree(theXMLString);
	}

return(theStringValue);
}

- (NSUInteger)index
{
NSAssert(_node != NULL, @"TODO");

xmlNodePtr theCurrentNode = _node->prev;
NSUInteger N;
for (N = 0; theCurrentNode != NULL; ++N, theCurrentNode = theCurrentNode->prev)
	;
return(N);
}

- (NSUInteger)level
{
NSAssert(_node != NULL, @"TODO");

xmlNodePtr theCurrentNode = _node->parent;
NSUInteger N;
for (N = 0; theCurrentNode != NULL; ++N, theCurrentNode = theCurrentNode->parent)
	;
return(N);
}

- (CXMLDocument *)rootDocument
{
NSAssert(_node != NULL, @"TODO");

return(_node->doc->_private);
}

- (CXMLNode *)parent
{
NSAssert(_node != NULL, @"TODO");

if (_node->parent == NULL)
	return(NULL);
else
	return (_node->parent->_private);
}

- (NSUInteger)childCount
{
NSAssert(_node != NULL, @"TODO");

xmlNodePtr theCurrentNode = _node->children;
NSUInteger N;
for (N = 0; theCurrentNode != NULL; ++N, theCurrentNode = theCurrentNode->next)
	;
return(N);
}

- (NSArray *)children
{
NSAssert(_node != NULL, @"TODO");

NSMutableArray *theChildren = [NSMutableArray array];
xmlNodePtr theCurrentNode = _node->children;
while (theCurrentNode != NULL)
	{
	CXMLNode *theNode = [CXMLNode nodeWithLibXMLNode:theCurrentNode];
	[theChildren addObject:theNode];
	theCurrentNode = theCurrentNode->next;
	}
return(theChildren);      
}

- (CXMLNode *)childAtIndex:(NSUInteger)index
{
NSAssert(_node != NULL, @"TODO");

xmlNodePtr theCurrentNode = _node->children;
NSUInteger N;
for (N = 0; theCurrentNode != NULL && N != index; ++N, theCurrentNode = theCurrentNode->next)
	;
if (theCurrentNode)
	return([CXMLNode nodeWithLibXMLNode:theCurrentNode]);
return(NULL);
}

- (CXMLNode *)previousSibling
{
NSAssert(_node != NULL, @"TODO");

if (_node->prev == NULL)
	return(NULL);
else
	return([CXMLNode nodeWithLibXMLNode:_node->prev]);
}

- (CXMLNode *)nextSibling
{
NSAssert(_node != NULL, @"TODO");

if (_node->next == NULL)
	return(NULL);
else
	return([CXMLNode nodeWithLibXMLNode:_node->next]);
}

//- (CXMLNode *)previousNode;
//- (CXMLNode *)nextNode;
//- (NSString *)XPath;
//- (NSString *)localName;
//- (NSString *)prefix;
//- (NSString *)URI;
//+ (NSString *)localNameForName:(NSString *)name;
//+ (NSString *)prefixForName:(NSString *)name;
//+ (CXMLNode *)predefinedNamespaceForPrefix:(NSString *)name;

- (NSString *)description
{
NSAssert(_node != NULL, @"TODO");

return([NSString stringWithFormat:@"<%@ %p %@ %@>", NSStringFromClass([self class]), self, [self name], [self stringValue]]);
}

//- (NSString *)XMLString;
//- (NSString *)XMLStringWithOptions:(NSUInteger)options;
//- (NSString *)canonicalXMLStringPreservingComments:(BOOL)comments;

- (NSArray *)nodesForXPath:(NSString *)xpath error:(NSError **)error
{
NSAssert(_node != NULL, @"TODO");

NSArray *theResult = NULL;

CXMLNode *theRootDocument = [self rootDocument];
xmlXPathContextPtr theXPathContext = xmlXPathNewContext((xmlDocPtr)theRootDocument->_node);

// TODO considering putting xmlChar <-> UTF8 into a NSString category
xmlXPathObjectPtr theXPathObject = xmlXPathEvalExpression((const xmlChar *)[xpath UTF8String], theXPathContext);
if (xmlXPathNodeSetIsEmpty(theXPathObject->nodesetval))
	theResult = [NSArray array]; // TODO better to return NULL?
else
	{
	NSMutableArray *theArray = [NSMutableArray array];
	int N;
	for (N = 0; N < theXPathObject->nodesetval->nodeNr; N++)
		{
		xmlNodePtr theNode = theXPathObject->nodesetval->nodeTab[N];
		[theArray addObject:[CXMLNode nodeWithLibXMLNode:theNode]];
		}
		
	theResult = theArray;
	}

xmlXPathFreeContext(theXPathContext);
return(theResult);
}

//- (NSArray *)objectsForXQuery:(NSString *)xquery constants:(NSDictionary *)constants error:(NSError **)error;
//- (NSArray *)objectsForXQuery:(NSString *)xquery error:(NSError **)error;


@end
