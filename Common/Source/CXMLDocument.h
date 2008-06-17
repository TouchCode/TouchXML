//
//  CXMLDocument.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode.h"

enum {
	CXMLDocumentTidyHTML = 1 << 9
};

@class CXMLElement;

@interface CXMLDocument : CXMLNode {
	NSMutableSet *nodePool;
}

- (id)initWithXMLString:(NSString *)inString options:(NSUInteger)inOptions error:(NSError **)outError;
- (id)initWithContentsOfURL:(NSURL *)inURL options:(NSUInteger)inOptions error:(NSError **)outError;
- (id)initWithData:(NSData *)inData options:(NSUInteger)inOptions error:(NSError **)outError;

//- (NSString *)characterEncoding;
//- (NSString *)version;
//- (BOOL)isStandalone;
//- (CXMLDocumentContentKind)documentContentKind;
//- (NSString *)MIMEType;
//- (CXMLDTD *)DTD;

- (CXMLElement *)rootElement;

//- (NSData *)XMLData;
//- (NSData *)XMLDataWithOptions:(NSUInteger)options;

//- (id)objectByApplyingXSLT:(NSData *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (id)objectByApplyingXSLTString:(NSString *)xslt arguments:(NSDictionary *)arguments error:(NSError **)error;
//- (id)objectByApplyingXSLTAtURL:(NSURL *)xsltURL arguments:(NSDictionary *)argument error:(NSError **)error;

//- (id)XMLStringWithOptions:(NSUInteger)options;

@end
