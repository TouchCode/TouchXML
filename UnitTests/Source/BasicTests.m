//
//  BasicTests.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BasicTests.h"

#import "CXMLDocument.h"

@implementation BasicTests

- (void)test_basicXMLTest
{
NSError *theError = NULL;
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:@"<foo/>" options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, @"-");
STAssertNil(theError, @"-");
STAssertNotNil([theXMLDocument rootElement], @"-");
STAssertEquals([theXMLDocument rootElement], [theXMLDocument rootElement], @"-");
STAssertEqualObjects([[theXMLDocument rootElement] name], @"foo", @"-");
}

- (void)test_badXMLTest
{
NSError *theError = NULL;
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:@"This is invalid XML." options:0 error:&theError] autorelease];
STAssertNil(theXMLDocument, @"-");
STAssertNotNil(theError, @"-");
}

- (void)test_nodeNavigation
{
NSError *theError = NULL;
NSString *theXML = @"<root><node_1/><node_2/><node_3/></root>";
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, @"-");

STAssertTrue([[theXMLDocument rootElement] childCount] == 3, @"-");

NSArray *theArray = [theXMLDocument nodesForXPath:@"/root/*" error:&theError];
STAssertNotNil(theArray, @"-");
STAssertTrue([theArray count] == 3, @"-");
for (CXMLNode *theNode in theArray)
	{
	STAssertEquals([theNode index], [theArray indexOfObject:theNode], @"-");
	STAssertEquals((int)[theNode level], 2, @"-");
	}
	
STAssertEquals([[theXMLDocument rootElement] childAtIndex:0], [theArray objectAtIndex:0], @"-");
STAssertEquals([[theXMLDocument rootElement] childAtIndex:1], [theArray objectAtIndex:1], @"-");
STAssertEquals([[theXMLDocument rootElement] childAtIndex:2], [theArray objectAtIndex:2], @"-");

STAssertEqualObjects([[theArray objectAtIndex:0] name], @"node_1", @"-");
STAssertEqualObjects([[theArray objectAtIndex:1] name], @"node_2", @"-");
STAssertEqualObjects([[theArray objectAtIndex:2] name], @"node_3", @"-");

STAssertEquals([[theArray objectAtIndex:0] nextSibling], [theArray objectAtIndex:1], @"-");
STAssertEquals([[theArray objectAtIndex:1] nextSibling], [theArray objectAtIndex:2], @"-");
STAssertNil([[theArray objectAtIndex:2] nextSibling], @"-");

STAssertNil([[theArray objectAtIndex:0] previousSibling], @"-");
STAssertEquals([[theArray objectAtIndex:1] previousSibling], [theArray objectAtIndex:0], @"-");
STAssertEquals([[theArray objectAtIndex:2] previousSibling], [theArray objectAtIndex:1], @"-");

}



@end
