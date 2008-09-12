//
//  main.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/07/08.
//  Copyright (c) 2008 Jonathan Wight
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
