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

NSData *theData = [@"<outer x='foo'><inner y='bar'/></outer>" dataUsingEncoding:NSUTF8StringEncoding];
NSError *theError = NULL;
CXMLDocument *theDocument = [[[CXMLDocument alloc] initWithData:theData options:0 error:&theError] autorelease];
NSLog(@"%@", theDocument);
NSLog(@"X: %@", [theDocument nodesForXPath:@"/outer/inner" error:NULL]);
NSLog(@"X: %@", [theDocument nodesForXPath:@"/outer/inner/@y" error:NULL]);
NSLog(@"%@", [theDocument rootElement]);
NSLog(@"%@", [[theDocument rootElement] elementsForName:@"inner"]);
NSLog(@"%@", [[theDocument rootElement] attributes]);
NSLog(@"%@", [[[theDocument rootElement] attributeForName:@"x"] children]);
NSLog(@"%@", [[[theDocument rootElement] attributeForName:@"x"] children]);
NSLog(@"%@", [[[theDocument rootElement] attributeForName:@"x"] stringValue]);
for (id theNode in [[theDocument rootElement] children])
	{
	NSLog(@"%@", theNode);
	NSLog(@"%@", [theNode parent]);
	NSLog(@"%@", [[theNode parent] parent]);
	NSLog(@"%@", [theNode rootDocument]);
	}

[pool release];
return 0;
}
