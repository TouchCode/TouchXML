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
		//
		NSError *theError = NULL;
		CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:inXMLString options:0 error:&theError] autorelease];
		if (theXMLDocument)
			self.status = @"OK";
		else
			self.status = [theError description];
		}
	
	}
}

@end
