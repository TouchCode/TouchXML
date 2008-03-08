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
NSString *theXML = @"<root attribute='bad'><anchor><node attribute='good'/></anchor></root>";
id theXMLDocument = [[[NSXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];
NSLog(@"%@", theXMLDocument);

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//@attribute" error:&theError];
NSLog(@"%@", theNodes);

[pool release];
return 0;
}
