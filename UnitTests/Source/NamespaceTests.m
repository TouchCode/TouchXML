//
//  NamespaceTests.m
//  TouchXML
//

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
	
	for (int i = 0; i < [txNamespaces count]; i++)
	{
		[self assertTouchNode:[txNamespaces objectAtIndex:i] 
			 matchesNSXMLNode:[nsNamespaces objectAtIndex:i] 
				  describedAs:@"Comparing namespaces"];
	}
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

@end
