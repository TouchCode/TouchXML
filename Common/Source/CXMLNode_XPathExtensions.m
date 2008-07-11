//
//  CXMLNode_XPathExtensions.m
//  TouchXML
//
//  Created by Jonathan Wight on 04/01/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CXMLNode_XPathExtensions.h"

#import "CXMLDocument.h"
#import "CXMLNode_PrivateExtensions.h"

#include <libxml/xpath.h>
#include <libxml/xpathInternals.h>

@implementation CXMLNode (CXMLNode_NamespaceExtensions)

- (NSArray *)nodesForXPath:(NSString *)xpath namespaceMappings:(NSDictionary *)inNamespaceMappings error:(NSError **)error;
{
NSAssert(_node != NULL, @"TODO");

NSArray *theResult = NULL;

CXMLNode *theRootDocument = [self rootDocument];
xmlXPathContextPtr theXPathContext = xmlXPathNewContext((xmlDocPtr)theRootDocument->_node);
theXPathContext->node = _node;

for (NSString *thePrefix in inNamespaceMappings)
	{
	xmlXPathRegisterNs(theXPathContext, (xmlChar *)[thePrefix UTF8String], (xmlChar *)[[inNamespaceMappings objectForKey:thePrefix] UTF8String]);
	}

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
	
xmlXPathFreeObject(theXPathObject);

xmlXPathFreeContext(theXPathContext);
return(theResult);
}

@end
