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

static const NSString *NS1 = @"http://example.org/xmlns/";

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
//  Assertion helpers
//
//--------------------------------------------------------------------------

- (void) assertTouchElement:(CXMLElement *)txElement matchesNSXMLElement:(NSXMLElement *)nsElement
{
	STAssertEqualObjects([txElement name], 
						 [nsElement name],
						 @"for name, touch gave me %@, nsxml gave me %@",
						 [txElement name], 
						 [nsElement name]);

	STAssertEqualObjects([txElement localName], 
						 [nsElement localName],
						 @"for localName, touch gave me %@, nsxml gave me %@",
						 [txElement localName], 
						 [nsElement localName]);

	STAssertEqualObjects([txElement URI], 
						 [nsElement URI],
						 @"for URI, touch gave me %@, nsxml gave me %@",
						 [txElement URI], 
						 [nsElement URI]);
	
	STAssertEqualObjects([txElement prefix], 
						 [nsElement prefix],
						 @"for prefix, touch gave me %@, nsxml gave me %@",
						 [txElement prefix], 
						 [nsElement prefix]);
	
}

//--------------------------------------------------------------------------
//
//  Tests
//
//--------------------------------------------------------------------------
			
- (void) test_noNamespaceTest
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

- (void) test_basicNamespaceTest1
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

- (void) test_basicNamespaceTest2
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

@end
