//
//  XPath_Tests.m
//  TouchCode
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 toxicsoftware.com. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "XPath_Tests.h"

#import "CXMLDocument.h"
#import "CXMLElement.h"
#import "CXMLNode_XPathExtensions.h"

@implementation XPath_Tests

- (void)test_nodeNavigation
{
NSError *theError = NULL;
NSString *theXML = @"<root attribute='bad'><anchor><node attribute='good'/></anchor></root>";
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, NULL);

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//@attribute" error:&theError];
STAssertTrue([theNodes count] == 2, NULL);
}

- (void)test_xmlns
{
NSError *theError = NULL;
NSString *theXML = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><FindItemsResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\"><Timestamp>2008-03-26T23:23:13.175Z</Timestamp></FindItemsResponse>";

CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, NULL);

NSArray *theNodes = NULL;

NSDictionary *theMappings = [NSDictionary dictionaryWithObjectsAndKeys:
	@"urn:ebay:apis:eBLBaseComponents", @"ebay",
	NULL];

theNodes = [theXMLDocument nodesForXPath:@"//ebay:Timestamp" namespaceMappings:theMappings error:&theError];
STAssertTrue([theNodes count] == 1, NULL);
}

- (void)test_relative_paths
{
NSError *theError = NULL;
NSString *theXML = @"<root attribute='bad'><mid><node attribute='good'/></mid></root>";

CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, NULL);

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//mid" error:&theError];
STAssertTrue([theNodes count] == 1, NULL);
for (CXMLElement *theElement in theNodes)
	{
	theNodes = [theElement nodesForXPath:@"./node" error:NULL];
	STAssertTrue([theNodes count] == 1, NULL);
	}
}


@end
