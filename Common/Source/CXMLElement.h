//
//  CXMLElement.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CXMLNode.h"

// NSXMLElement
@interface CXMLElement : CXMLNode {

}

- (NSArray *)elementsForName:(NSString *)name;
//- (NSArray *)elementsForLocalName:(NSString *)localName URI:(NSString *)URI;

- (NSArray *)attributes;
- (CXMLNode *)attributeForName:(NSString *)name;
//- (CXMLNode *)attributeForLocalName:(NSString *)localName URI:(NSString *)URI;

//- (NSArray *)namespaces; //primitive
//- (CXMLNode *)namespaceForPrefix:(NSString *)name;
//- (CXMLNode *)resolveNamespaceForName:(NSString *)name;
//- (NSString *)resolvePrefixForNamespaceURI:(NSString *)namespaceURI;

- (NSString*)_XMLStringWithOptions:(NSUInteger)options appendingToString:(NSMutableString*)str;
@end
