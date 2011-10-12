//
//  XPath_Tests.m
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
