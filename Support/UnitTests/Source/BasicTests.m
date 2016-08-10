//
//  BasicTests.m
//  TouchCode
//
//  Created by Jonathan Wight on 03/07/08.
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

#import "BasicTests.h"

#import "CXMLDocument.h"
#import "CXMLElement.h"

@implementation BasicTests

- (void)test_basicXMLTest
{
    NSError *theError = NULL;
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:@"<foo/>" options:0 error:&theError];
    XCTAssertNotNil(theXMLDocument);
    XCTAssertNil(theError);
    XCTAssertNotNil([theXMLDocument rootElement]);
    XCTAssertEqual([theXMLDocument rootElement], [theXMLDocument rootElement]);
    XCTAssertEqualObjects([[theXMLDocument rootElement] name], @"foo");
}

- (void)test_strings
{
    NSError *theError = NULL;
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:@"<x>test</x>" options:0 error:&theError];
    CXMLElement *theElement = [theXMLDocument rootElement];
    XCTAssertEqualObjects([theElement stringValue], @"test");
    CXMLNode *theNode = [[theElement children] objectAtIndex:0];
    XCTAssertEqualObjects([theNode stringValue], @"test");
}

- (void)test_cdata
{
    NSError *theError = NULL;
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:@"<x><![CDATA[test]]></x>" options:0 error:&theError];
    CXMLElement *theElement = [theXMLDocument rootElement];
    XCTAssertEqualObjects([theElement stringValue], @"test");
    CXMLNode *theNode = [[theElement children] objectAtIndex:0];
    XCTAssertEqualObjects([theNode stringValue], @"test");
}

- (void)test_badXMLTest
{
    NSError *theError = NULL;
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:@"This is invalid XML." options:0 error:&theError];
    XCTAssertNil(theXMLDocument);
    XCTAssertNotNil(theError);
}

- (void)test_badXMLTestFromData
{
	NSError *theError = NULL;
	NSData *theData=[@"This is invalid XML." dataUsingEncoding:NSUTF8StringEncoding];
	CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithData:theData options:0 error:&theError];
	XCTAssertNil(theXMLDocument);
	XCTAssertNotNil(theError);
}

- (void)test_nodeNavigation
{
    NSError *theError = NULL;
    NSString *theXML = @"<root><node_1/><node_2/><node_3/></root>";
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError];
    XCTAssertNotNil(theXMLDocument);
    
    XCTAssertTrue([[theXMLDocument rootElement] childCount] == 3);
    
    NSArray *theArray = [theXMLDocument nodesForXPath:@"/root/*" error:&theError];
    XCTAssertNotNil(theArray);
    XCTAssertTrue([theArray count] == 3);
    for (CXMLNode *theNode in theArray)
	{
        XCTAssertEqual([theNode index], [theArray indexOfObject:theNode]);
        XCTAssertEqual((int)[theNode level], 2);
	}
	
    XCTAssertEqual([[theXMLDocument rootElement] childAtIndex:0], [theArray objectAtIndex:0]);
    XCTAssertEqual([[theXMLDocument rootElement] childAtIndex:1], [theArray objectAtIndex:1]);
    XCTAssertEqual([[theXMLDocument rootElement] childAtIndex:2], [theArray objectAtIndex:2]);
    
    XCTAssertEqualObjects([[theArray objectAtIndex:0] name], @"node_1");
    XCTAssertEqualObjects([[theArray objectAtIndex:1] name], @"node_2");
    XCTAssertEqualObjects([[theArray objectAtIndex:2] name], @"node_3");
    
    XCTAssertEqual([[theArray objectAtIndex:0] nextSibling], [theArray objectAtIndex:1]);
    XCTAssertEqual([[theArray objectAtIndex:1] nextSibling], [theArray objectAtIndex:2]);
    XCTAssertNil([[theArray objectAtIndex:2] nextSibling]);
    
    XCTAssertNil([[theArray objectAtIndex:0] previousSibling]);
    XCTAssertEqual([[theArray objectAtIndex:1] previousSibling], [theArray objectAtIndex:0]);
    XCTAssertEqual([[theArray objectAtIndex:2] previousSibling], [theArray objectAtIndex:1]);
}

- (void)test_valid_and_invalid_Xpaths
{
    
}

- (void)test_attributes
{
    NSError *theError = NULL;
    NSString *theXML = @"<root><node_1/><node_2 attribute_1='value_1' /><node_3 attribute_1='value_1' attribute_2='value_2' /></root>";
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError];
    XCTAssertNotNil(theXMLDocument);
    
    NSArray *theNodes = NULL;
    CXMLElement *theElement = NULL;
    
    theNodes = [[theXMLDocument rootElement] elementsForName:@"node_1"];
    XCTAssertTrue([theNodes count] == 1);
    theElement = [theNodes lastObject];
    XCTAssertTrue([theElement isKindOfClass:[CXMLElement class]]);
    XCTAssertNotNil([theElement attributes]);
    XCTAssertTrue([[theElement attributes] count] == 0);
    
    theNodes = [[theXMLDocument rootElement] elementsForName:@"node_2"];
    XCTAssertTrue([theNodes count] == 1);
    theElement = [theNodes lastObject];
    XCTAssertTrue([theElement isKindOfClass:[CXMLElement class]]);
    XCTAssertNotNil([theElement attributes]);
    XCTAssertTrue([[theElement attributes] count] == 1);
    XCTAssertEqualObjects([[theElement attributes] objectAtIndex:0], [theElement attributeForName:@"attribute_1"]);
    XCTAssertEqualObjects([[theElement attributeForName:@"attribute_1"] stringValue], @"value_1");
    
    theNodes = [[theXMLDocument rootElement] elementsForName:@"node_3"];
    XCTAssertTrue([theNodes count] == 1);
    theElement = [theNodes lastObject];
    XCTAssertTrue([theElement isKindOfClass:[CXMLElement class]]);
    XCTAssertNotNil([theElement attributes]);
    XCTAssertTrue([[theElement attributes] count] == 2);
    XCTAssertEqualObjects([[theElement attributes] objectAtIndex:0], [theElement attributeForName:@"attribute_1"]);
    XCTAssertEqualObjects([[theElement attributes] objectAtIndex:1], [theElement attributeForName:@"attribute_2"]);
    XCTAssertEqualObjects([[theElement attributeForName:@"attribute_1"] stringValue], @"value_1");
    XCTAssertEqualObjects([[theElement attributeForName:@"attribute_2"] stringValue], @"value_2");
}

- (void)test_brokenEntity
{
    NSError *theError = NULL;
    CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:@"<foo>http://website.com?foo=1&bar=2</foo>" options:0 error:&theError];
    XCTAssertNil(theXMLDocument);
}

@end
