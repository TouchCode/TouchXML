//
//  XPath_Tests.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "XPath_Tests.h"

#import "CXMLDocument.h"
#import "CXMLElement.h"

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

/* THIS FAILS
- (void)test_xmlns
{
NSError *theError = NULL;
NSString *theXML = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><FindItemsResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\"><Timestamp>2008-03-26T23:23:13.175Z</Timestamp></FindItemsResponse>";

CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
STAssertNotNil(theXMLDocument, NULL);

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//Timestamp" error:&theError];
STAssertTrue([theNodes count] == 1, NULL);
}
*/

@end
