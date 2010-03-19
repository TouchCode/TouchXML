//
//  CMainController.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/18/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CMainController.h"

#import "CXMLDocument.h"

@implementation CMainController

@synthesize window;
@synthesize XMLString;
@synthesize XPath;
@synthesize status;

- (void)applicationDidFinishLaunching:(NSNotification *)inNotification
{
NSLog(@"Finish");
}

- (void)setXMLString:(NSString *)inXMLString
{
if (inXMLString != XMLString)
	{
	if (XMLString)
		{
		[XMLString release];
		XMLString = NULL;
		}
		
	if (inXMLString)
		{
		XMLString = [inXMLString copy];
		[self updateStatus];
		}
	}
}

- (void)setXPath:(NSString *)inXPath
{
if (inXPath != XPath)
	{
	if (XPath)
		{
		[XPath release];
		XPath = NULL;
		}
		
	if (inXPath)
		{
		XPath = [inXPath copy];
		[self updateStatus];
		}
	}
}

- (void)updateStatus
{
NSError *theError = NULL;
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:self.XMLString options:0 error:&theError] autorelease];
if (theXMLDocument)
	{
	if (self.XPath.length > 0)
		{
		NSArray *theNodes = [theXMLDocument nodesForXPath:self.XPath error:&theError];
		if (theNodes)
			self.status = [theNodes description];
		else
			self.status = @"OK";
		}
	else
		self.status = @"OK";
	}
else
	self.status = [theError description];

}

@end
