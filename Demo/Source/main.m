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
NSString *theXML = @"<root attribute='bad'><mid><node attribute='good'/></mid></root>";

CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:theXML options:0 error:&theError] autorelease];

NSArray *theNodes = NULL;

theNodes = [theXMLDocument nodesForXPath:@"//mid" error:&theError];
for (CXMLElement *theElement in theNodes)
	{
	theNodes = [theElement nodesForXPath:@"./node" error:NULL];
	NSLog(@"%@", theNodes);
	}

[pool release];
return 0;
}
