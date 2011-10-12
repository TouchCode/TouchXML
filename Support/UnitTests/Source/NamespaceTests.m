//
//  NamespaceTests.m
//  TouchXML
//
//  Created by Jonathan Wight on 1/1/2000.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//     1. Redistributions of source code must retain the above copyright notice, this list of
//        conditions and the following disclaimer.
//
//     2. Redistributions in binary form must reproduce the above copyright notice, this list
//        of conditions and the following disclaimer in the documentation and/or other materials
//        provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY TOXICSOFTWARE.COM ``AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL TOXICSOFTWARE.COM OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of toxicsoftware.com.

#import "NamespaceTests.h"

#import "CXMLDocument.h"
#import "CXMLElement.h"
#import "CXMLNode.h"

@implementation NamespaceTests 
	
//--------------------------------------------------------------------------
//
//  Constants
//
//--------------------------------------------------------------------------

static const NSString *NS1 = @"http://example.org/xmlns/1/";
static const NSString *NS2 = @"http://example.org/xmlns/2/";

//--------------------------------------------------------------------------
//
//  Source helpers
//
//--------------------------------------------------------------------------

NSString *emptyDocumentNoPrefix()
{
	return [NSString stringWithFormat:@"<rootElement xmlns=\"%@\"/>", NS1];
}

NSString *emptyDocumentWithPrefix()
{
	return [NSString stringWithFormat:@"<ns1:rootElement xmlns:ns1=\"%@\"/>", NS1];
}

NSString *emptyDocumentWithAttributesNoPrefix()
{
	return [NSString stringWithFormat:@"<rootElement anAttribute=\"aValue\" xmlns=\"%@\"/>", NS1];
}

NSString *emptyDocumentWithAttributesWithPrefix()
{
	return [NSString stringWithFormat:@"<ns2:rootElement ns2:anAttribute=\"aValue\" xmlns:ns2=\"%@\"/>", NS2];
}

NSString *emptyDocumentWithAttributesMixed()
{
	return [NSString stringWithFormat:@"<ns2:rootElement ns2:attr1=\"value1\" attr2=\"wrongValue\" ns1:attr2=\"value2\" attr3=\"value3\" xmlns:ns1=\"%@\" xmlns:ns2=\"%@\"/>", NS1, NS2];
}

NSString *simpleDocument()
{
	return [NSString stringWithFormat:
			@"<ns1:rootElement xmlns:ns1=\"%@\" xmlns:ns2=\"%@\">"
			"<ns1:childElement>alpha</ns1:childElement>"
			"<ns1:childElement>bravo</ns1:childElement>"
			"<ns2:childElement>charlie</ns2:childElement>"
			"<ns1:childElement>delta</ns1:childElement>"
			"<ns1:childElement>echo</ns1:childElement>"
			"<ns2:childElement>foxtrot</ns2:childElement>"
			"<ns2:childElement>golf</ns2:childElement>"
			"<ns1:childElement>helo</ns1:childElement>"
			"<childElement>igloo</childElement>"
			"<ns1:childElement>"
			"<ns2:childElement>juliet</ns2:childElement>"
			"<ns2:childElement>kilo</ns2:childElement>"
			"<ns2:childElement>lima</ns2:childElement>"
			"</ns1:childElement>"
			"</ns1:rootElement>", NS1, NS2];
}

//--------------------------------------------------------------------------
//
//  Builder helpers
//
//--------------------------------------------------------------------------

- (void) buildTouchDocument:(CXMLDocument **)txDoc andNSXMLDocument:(NSXMLDocument **)nsDoc withXMLString:(NSString *)source
{
	NSError *error = nil;
	NSUInteger nsOptions = NSXMLNodePreserveAll;
	
	*txDoc = [[[CXMLDocument alloc] initWithXMLString:source options:nsOptions error:&error] autorelease];
	STAssertNil(error, @"Error building touch doc");
	
	*nsDoc = [[[NSXMLDocument alloc] initWithXMLString:source options:nsOptions error:&error] autorelease];
	STAssertNil(error, @"Error building nsXML doc");
}

//--------------------------------------------------------------------------
//
//  Enum decoder helpers
//
//--------------------------------------------------------------------------

NSString *stringValueOfCXMLNodeKind(CXMLNodeKind kind) 
{
	if (kind == CXMLInvalidKind) return @"InvalidKind";
	if (kind == CXMLElementKind) return @"ElementKind";
	if (kind == CXMLAttributeKind) return @"AttributeKind";
	if (kind == CXMLTextKind) return @"TextKind";
	if (kind == CXMLProcessingInstructionKind) return @"ProcessingInstructionKind";
	if (kind == CXMLCommentKind) return @"CommentKind";
	if (kind == CXMLNotationDeclarationKind) return @"NotationDeclarationKind";
	if (kind == CXMLDTDKind) return @"DTDKind";
	if (kind == CXMLElementDeclarationKind) return @"ElementDeclarationKind";
	if (kind == CXMLAttributeDeclarationKind) return @"AttributeDeclarationKind";
	if (kind == CXMLEntityDeclarationKind) return @"EntityDeclarationKind";
	if (kind == CXMLNamespaceKind) return @"NamespaceKind";
	
	return @"Unknown CXMLNodeKind";
}

NSString *stringValueOfNSXMLNodeKind(NSXMLNodeKind kind)
{
	if (kind == NSXMLInvalidKind) return @"InvalidKind";
	if (kind == NSXMLDocumentKind) return @"DocumentKind";
	if (kind == NSXMLElementKind) return @"ElementKind";
	if (kind == NSXMLAttributeKind) return @"AttributeKind";
	if (kind == NSXMLNamespaceKind) return @"NamespaceKind";
	if (kind == NSXMLProcessingInstructionKind) return @"ProcessingInstructionKind";
	if (kind == NSXMLCommentKind) return @"CommentKind";
	if (kind == NSXMLTextKind) return @"TextKind";
	if (kind == NSXMLDTDKind) return @"DTDKind";
	if (kind == NSXMLEntityDeclarationKind) return @"EntityDeclarationKind";
	if (kind == NSXMLAttributeDeclarationKind) return @"AttributeDeclarationKind";
	if (kind == NSXMLElementDeclarationKind) return @"ElementDeclarationKind";
	if (kind == NSXMLNotationDeclarationKind) return @"NotationDeclarationKind";	
	
	return @"Unknown NSXMLNodeKind";
}
	
//--------------------------------------------------------------------------
//
//  Assertion helpers
//
//--------------------------------------------------------------------------

- (void) assertTouchNode:(CXMLNode *)txNode matchesNSXMLNode:(NSXMLNode *)nsNode describedAs:(NSString *)desc
{
	if (txNode == nil && nsNode == nil) return; // Equal
	
	STAssertNotNil(txNode, @"Running \"%@\" touch node nil, nsNode is %@", nsNode); 
	STAssertNotNil(txNode, @"Running \"%@\" nsXML node nil, touch node is %@", txNode); 
	
	STAssertEqualObjects(stringValueOfCXMLNodeKind([txNode kind]),
						 stringValueOfNSXMLNodeKind([nsNode kind]),
						 @"Running \"%@\" - For kind, touch gave me %@, nsxml gave me %@", desc,
						 stringValueOfCXMLNodeKind([txNode kind]),
						 stringValueOfNSXMLNodeKind([nsNode kind]));
	
	STAssertEqualObjects([txNode name], 
						 [nsNode name],
						 @"Running \"%@\" - For name, touch gave me %@, nsxml gave me %@", desc,
						 [txNode name], 
						 [nsNode name]);

	if ([nsNode kind] != NSXMLNamespaceKind)
	{
		// Bug in cocoa's -localName impl means we can't run this on namespace nodes.
		
		STAssertEqualObjects([txNode localName], 
							 [nsNode localName],
							 @"Running \"%@\" - For localName, touch gave me %@, nsxml gave me %@", desc,
							 [txNode localName], 
							 [nsNode localName]);
	}
	
	STAssertEqualObjects([txNode URI], 
						 [nsNode URI],
						 @"Running \"%@\" - For URI, touch gave me %@, nsxml gave me %@", desc,
						 [txNode URI], 
						 [nsNode URI]);
	
	STAssertEqualObjects([txNode prefix], 
						 [nsNode prefix],
						 @"Running \"%@\" - For prefix, touch gave me %@, nsxml gave me %@", desc,
						 [txNode prefix], 
						 [nsNode prefix]);
	
	STAssertEqualObjects([txNode stringValue], 
						 [nsNode stringValue],
						 @"Running \"%@\" - For stringValue, touch gave me %@, nsxml gave me %@", desc,
						 [txNode stringValue], 
						 [nsNode stringValue]);
	
	STAssertEquals([txNode childCount],
				   [nsNode childCount],
				   @"Running \"%@\" - For childCount, touch gave me %d, nsxml gave me %d", desc,
				   [txNode childCount],
				   [nsNode childCount]);

	STAssertEquals([[txNode children] count],
				   [[nsNode children] count],
				   @"Running \"%@\" - For [children count], touch gave me %d, nsxml gave me %d", desc,
				   [[txNode children] count],
				   [[nsNode children] count]);
}

- (void) assertTouchElement:(CXMLElement *)txElement matchesNSXMLElement:(NSXMLElement *)nsElement describedAs:(NSString *)desc
{
	[self assertTouchNode:txElement matchesNSXMLNode:nsElement describedAs:desc];
	
	NSArray *txNamespaces = [txElement namespaces];
	NSArray *nsNamespaces = [nsElement namespaces];
	
	STAssertEquals([txNamespaces count],
				   [nsNamespaces count],
				   @"Running \"%@\" - For [namespaces count], touch gave me %d, nsxml gave me %d", desc,
				   [txNamespaces count],
				   [nsNamespaces count]);

	CXMLNode *txNamespaceNode;
	NSXMLNode *nsNamespaceNode;

	for (int i = 0; i < [txNamespaces count]; i++)
	{
		txNamespaceNode = [txNamespaces objectAtIndex:i];
		nsNamespaceNode = [nsNamespaces objectAtIndex:i];
		
		[self assertTouchNode:txNamespaceNode
			 matchesNSXMLNode:nsNamespaceNode
				  describedAs:@"Comparing namespaces"];
	}
	
	txNamespaceNode = [txElement namespaceForPrefix:@"ns1"];
	nsNamespaceNode = [nsElement namespaceForPrefix:@"ns1"];
	
	[self assertTouchNode:txNamespaceNode
		 matchesNSXMLNode:nsNamespaceNode
			  describedAs:@"Comparing namespaceForPrefix \"ns1\""];

	txNamespaceNode = [txElement namespaceForPrefix:@"ns2"];
	nsNamespaceNode = [nsElement namespaceForPrefix:@"ns2"];
	
	[self assertTouchNode:txNamespaceNode
		 matchesNSXMLNode:nsNamespaceNode
			  describedAs:@"Comparing namespaceForPrefix \"ns2\""];
	
	txNamespaceNode = [txElement namespaceForPrefix:@"unused"];
	nsNamespaceNode = [nsElement namespaceForPrefix:@"unused"];
	
	[self assertTouchNode:txNamespaceNode
		 matchesNSXMLNode:nsNamespaceNode
			  describedAs:@"Comparing namespaceForPrefix \"unused\""];
}


- (void) assertTouchNode:(CXMLNode *)txNode matchesNSXMLNode:(NSXMLNode *)nsNode 
{
	[self assertTouchNode:txNode matchesNSXMLNode:nsNode describedAs:@"Test"];
}

- (void) assertTouchElement:(CXMLElement *)txElement matchesNSXMLElement:(NSXMLElement *)nsElement
{
	[self assertTouchElement:txElement matchesNSXMLElement:nsElement describedAs:@"Test"];
}

//--------------------------------------------------------------------------
//
//  Tests
//
//--------------------------------------------------------------------------
			
- (void) test_noNamespace
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:@"<rootNode/>"];
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");
	
	[self assertTouchElement:[txDoc rootElement] 
		 matchesNSXMLElement:[nsDoc rootElement]];	
}

- (void) test_basicNamespaceWithPrefix
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentWithPrefix()];
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");
	
	[self assertTouchElement:[txDoc rootElement] 
		 matchesNSXMLElement:[nsDoc rootElement]];
}

- (void) test_basicNamespaceNoPrefix
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentNoPrefix()];
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");
	
	[self assertTouchElement:[txDoc rootElement] 
		 matchesNSXMLElement:[nsDoc rootElement]];
}

- (void) test_namespacedAttributeNoPrefix
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentWithAttributesNoPrefix()];
	
	CXMLNode *txNode = [[[txDoc rootElement] attributes] objectAtIndex:0];
	NSXMLNode *nsNode = [[[nsDoc rootElement] attributes] objectAtIndex:0]; 
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");

	[self assertTouchNode:txNode matchesNSXMLNode:nsNode];
}

- (void) test_namespacedAttributeWithPrefix
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentWithAttributesWithPrefix()];
	
	CXMLNode *txNode = [[[txDoc rootElement] attributes] objectAtIndex:0];
	NSXMLNode *nsNode = [[[nsDoc rootElement] attributes] objectAtIndex:0]; 
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");
	
	[self assertTouchNode:txNode matchesNSXMLNode:nsNode];
}

- (void) test_namespacedAttributesMixed
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentWithAttributesMixed()];
	
	NSArray *txAttribs = [[txDoc rootElement] attributes];
	NSArray *nsAttribs = [[nsDoc rootElement] attributes];
	
	// Assertions
	
	STAssertNotNil(nsDoc, @"Couldn't build nsXML doc");
	STAssertNotNil(txDoc, @"Couldn't build touch doc");
	STAssertEquals([txAttribs count], [nsAttribs count],
				   @"Attribute count differs. Touch gives %d, nsXML gives %d",
				   [txAttribs count], [nsAttribs count]);
	
	for (int i = 0; i < [txAttribs count]; i++)
	{
		[self assertTouchNode:[txAttribs objectAtIndex:i] matchesNSXMLNode:[nsAttribs objectAtIndex:i]];
	}
}

- (void) test_getAttributeFullyQualified
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentWithAttributesMixed()];

	// Asserts
	
	CXMLNode *txNode = [[txDoc rootElement] attributeForLocalName:@"attr2" URI:(NSString *)NS1];
	NSXMLNode *nsNode = [[nsDoc rootElement] attributeForLocalName:@"attr2" URI:(NSString *)NS1];

	[self assertTouchNode:txNode matchesNSXMLNode:nsNode describedAs:@"Should find the fully qualified attribute"];

	txNode = [[txDoc rootElement] attributeForName:@"ns1:attr2"];
	nsNode = [[nsDoc rootElement] attributeForName:@"ns1:attr2"];
	
	[self assertTouchNode:txNode matchesNSXMLNode:nsNode describedAs:@"Searching by name with (correct) prefixed name"];

	txNode = [[txDoc rootElement] attributeForLocalName:@"attr3" URI:nil];
	nsNode = [[nsDoc rootElement] attributeForLocalName:@"attr3" URI:nil];
	
	[self assertTouchNode:txNode matchesNSXMLNode:nsNode describedAs:@"Fully qualified search with nil URI"];
}

- (void) test_getElementsFullyQualified
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:simpleDocument()];
	
	// Asserts
	
	CXMLElement *txElement = [txDoc rootElement];
	NSXMLElement *nsElement = [nsDoc rootElement];
	
	[self assertTouchElement:txElement matchesNSXMLElement:nsElement describedAs:@"Comparing rootElements"];
	
	NSArray *txChildren = [txElement elementsForLocalName:@"childElement" URI:(NSString *)NS1];
	NSArray *nsChildren = [nsElement elementsForLocalName:@"childElement" URI:(NSString *)NS1];

	STAssertEquals([txChildren count],
				   [nsChildren count],
				   @"Comparing list selected with URI, [txChildren count] is %d, [nsChildren count] is %d", 
				   [txChildren count],
				   [nsChildren count]);
	
	for (int i = 0; i < [txChildren count]; i++)
	{
		[self assertTouchElement:[txChildren objectAtIndex:i] 
			 matchesNSXMLElement:[nsChildren objectAtIndex:i] 
					 describedAs:@"Comparing elements selected with URI"];
	}
	
	txChildren = [txElement elementsForLocalName:@"ns2:childElement" URI:nil];
	nsChildren = [nsElement elementsForLocalName:@"ns2:childElement" URI:nil];
	
	STAssertEquals([txChildren count],
				   [nsChildren count],
				   @"Comparing list selected with nil URI but prefixed name, [txChildren count] is %d, [nsChildren count] is %d", 
				   [txChildren count],
				   [nsChildren count]);
	
	for (int i = 0; i < [txChildren count]; i++)
	{
		[self assertTouchElement:[txChildren objectAtIndex:i] 
			 matchesNSXMLElement:[nsChildren objectAtIndex:i] 
					 describedAs:@"Comparing elements selected with nil URI but prefixed name"];
	}
	
}

- (void) test_resolveNamespaceForName
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:simpleDocument()];
	
	CXMLElement *txRootElement = [txDoc rootElement];
	NSXMLElement *nsRootElement = [nsDoc rootElement];
	
	// Asserts
	
	[self assertTouchNode:[txRootElement resolveNamespaceForName:@"ns1:childElement"]
		 matchesNSXMLNode:[nsRootElement resolveNamespaceForName:@"ns1:childElement"]
			  describedAs:@"Resolving namespace for ns1(colon)childElement"];
	
	[self assertTouchNode:[txRootElement resolveNamespaceForName:@"ns2:childElement"]
		 matchesNSXMLNode:[nsRootElement resolveNamespaceForName:@"ns2:childElement"]
			  describedAs:@"Resolving namespace for ns2(colon)childElement"];
	
	[self assertTouchNode:[txRootElement resolveNamespaceForName:@"ns1:unusedElementName"]
		 matchesNSXMLNode:[nsRootElement resolveNamespaceForName:@"ns1:unusedElementName"]
			  describedAs:@"Resolving namespace for ns1(colon)unusedElementName"];
	
	[self assertTouchNode:[txRootElement resolveNamespaceForName:@"childElement"]
		 matchesNSXMLNode:[nsRootElement resolveNamespaceForName:@"childElement"]
			  describedAs:@"Resolving namespace for childElement"];
	
	[self assertTouchNode:[txRootElement resolveNamespaceForName:@"unused:childElement"]
		 matchesNSXMLNode:[nsRootElement resolveNamespaceForName:@"unused:childElement"]
			  describedAs:@"Resolving namespace for unused(colon)childElement"];
}

- (void) test_resolvePrefixForNamespaceURI
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:simpleDocument()];
	
	CXMLElement *txRootElement = [txDoc rootElement];
	NSXMLElement *nsRootElement = [nsDoc rootElement];
	
	// Asserts
	
	NSString *txURI = [txRootElement resolvePrefixForNamespaceURI:(NSString *)NS1];
	NSString *nsURI = [nsRootElement resolvePrefixForNamespaceURI:(NSString *)NS1];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", NS1,
						 txURI,
						 nsURI);
	
	txURI = [txRootElement resolvePrefixForNamespaceURI:(NSString *)NS2];
	nsURI = [nsRootElement resolvePrefixForNamespaceURI:(NSString *)NS2];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", NS2,
						 txURI,
						 nsURI);
	
	NSString *unusedNamespace = @"www.example.org/this/namespace/unused";
	
	txURI = [txRootElement resolvePrefixForNamespaceURI:unusedNamespace];
	nsURI = [nsRootElement resolvePrefixForNamespaceURI:unusedNamespace];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", unusedNamespace,
						 txURI,
						 nsURI);
	
}

- (void) test_resolvePrefixForNamespaceURI2
{
	CXMLDocument *txDoc = nil;
	NSXMLDocument *nsDoc = nil;
	
	// Setup 
	
	[self buildTouchDocument:&txDoc 
			andNSXMLDocument:&nsDoc 
			   withXMLString:emptyDocumentNoPrefix()];
	
	CXMLElement *txRootElement = [txDoc rootElement];
	NSXMLElement *nsRootElement = [nsDoc rootElement];
	
	// Asserts
	
	NSString *txURI = [txRootElement resolvePrefixForNamespaceURI:(NSString *)NS1];
	NSString *nsURI = [nsRootElement resolvePrefixForNamespaceURI:(NSString *)NS1];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", NS1,
						 txURI,
						 nsURI);
	
	txURI = [txRootElement resolvePrefixForNamespaceURI:(NSString *)NS2];
	nsURI = [nsRootElement resolvePrefixForNamespaceURI:(NSString *)NS2];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", NS2,
						 txURI,
						 nsURI);
	
	NSString *unusedNamespace = @"www.example.org/this/namespace/unused";
	
	txURI = [txRootElement resolvePrefixForNamespaceURI:unusedNamespace];
	nsURI = [nsRootElement resolvePrefixForNamespaceURI:unusedNamespace];
	
	STAssertEqualObjects(txURI,
						 nsURI,
						 @"Resolving prefix for \"%@\", touch gave me %@ but nsxml gave me %@", unusedNamespace,
						 txURI,
						 nsURI);
}

- (void) test_nameDivision
{
	NSString *name1 = @"aName";
	NSString *name2 = @"prefix:localName";
	NSString *name3 = @"p:localName";
	NSString *name4 = @"prefix:l";
	NSString *name5 = @"p:l";
	
	// Name 1
	
	NSString *str1 = [CXMLNode prefixForName:name1];
	NSString *str2 = [NSXMLNode prefixForName:name1];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing prefix for name1, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	str1 = [CXMLNode localNameForName:name1];
	str2 = [NSXMLNode localNameForName:name1];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing localName for name1, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	// Name 2
	
	str1 = [CXMLNode prefixForName:name2];
	str2 = [NSXMLNode prefixForName:name2];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing prefix for name2, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	str1 = [CXMLNode localNameForName:name2];
	str2 = [NSXMLNode localNameForName:name2];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing localName for name2, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	// Name 3
	
	str1 = [CXMLNode prefixForName:name3];
	str2 = [NSXMLNode prefixForName:name3];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing prefix for name3, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	str1 = [CXMLNode localNameForName:name3];
	str2 = [NSXMLNode localNameForName:name3];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing localName for name3, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	// Name 4
	
	str1 = [CXMLNode prefixForName:name4];
	str2 = [NSXMLNode prefixForName:name4];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing prefix for name4, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	str1 = [CXMLNode localNameForName:name4];
	str2 = [NSXMLNode localNameForName:name4];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing localName for name4, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	// Name 5
	
	str1 = [CXMLNode prefixForName:name5];
	str2 = [NSXMLNode prefixForName:name5];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing prefix for name5, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
	
	str1 = [CXMLNode localNameForName:name5];
	str2 = [NSXMLNode localNameForName:name5];
	
	STAssertEqualObjects(str1, 
						 str2,
						 @"Comparing localName for name5, touch gave me %@, nsxml gave me %@",
						 str1, 
						 str2);
}

@end
