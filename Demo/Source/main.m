//
//  main.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright Toxic Software 2008. All rights reserved.
//

#import "CXMLDocument.h"

int main(int argc, char *argv[])
{
NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

NSError *theError = NULL;
NSString *theXML = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><FindItemsResponse xmlns=\"urn:ebay:apis:eBLBaseComponents\"><Timestamp>2008-03-26T23:23:13.175Z</Timestamp></FindItemsResponse>";

CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//Timestamp" error:&theError];
NSLog(@"%@", theNodes);

[pool release];
return 0;
}
