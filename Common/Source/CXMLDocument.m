//
//  CXMLDocument
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLDocument.h"

#include <libxml/parser.h>

#import "CXMLNode_PrivateExtensions.h"
#import "CXMLElement.h"

@implementation CXMLDocument

- (id)initWithXMLString:(NSString *)inString options:(NSUInteger)inOptions error:(NSError **)outError
{
if ((self = [super init]) != NULL)
	{
	xmlDocPtr theDoc = xmlParseDoc((xmlChar *)[inString UTF8String]);
	
	if (theDoc != NULL)
		{
		_node = (xmlNodePtr)theDoc;
		_node->_private = self; // Note. NOT retained (TODO think more about _private usage)
		}
	else
		{
		if (outError)
			*outError = [NSError errorWithDomain:@"CXMLErrorDomain" code:1 userInfo:NULL];
		self = NULL;
		}
	}
return(self);
}

- (id)initWithData:(NSData *)inData options:(NSUInteger)inOptions error:(NSError **)outError
{
if ((self = [super init]) != NULL)
	{
	xmlDocPtr theDoc = xmlParseMemory([inData bytes], [inData length]);
	
	if (theDoc != NULL)
		{
		_node = (xmlNodePtr)theDoc;
		_node->_private = self; // Note. NOT retained (TODO think more about _private usage)
		}
	else
		{
		if (outError)
			*outError = [NSError errorWithDomain:@"CXMLErrorDomain" code:1 userInfo:NULL];
		self = NULL;
		}
	}
return(self);
}

- (void)dealloc
{
xmlFreeDoc((xmlDocPtr)_node);
_node = NULL;
//

[nodePool autorelease];
nodePool = NULL;
//
[super dealloc];
}

//- (NSString *)characterEncoding;
//- (NSString *)version;
//- (BOOL)isStandalone;
//- (CXMLDocumentContentKind)documentContentKind;
//- (NSString *)MIMEType;
//- (CXMLDTD *)DTD;

- (CXMLElement *)rootElement
{
xmlNodePtr theLibXMLNode = xmlDocGetRootElement((xmlDocPtr)_node);
	
return([CXMLNode nodeWithLibXMLNode:theLibXMLNode]);
}

//- (NSData *)XMLData;
//- (NSData *)XMLDataWithOptions:(NSUInteger)options;

//- (id)objectByApplyingXSLT:(NSData *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (id)objectByApplyingXSLTString:(NSString *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (id)objectByApplyingXSLTAtURL:(NSURL *)xsltURL arguments:(NSDictionary *)argument error:(NSError **)error;

@end
