//
//  CMainController.m
//  TouchCode
//
//  Created by Jonathan Wight on 03/18/10.
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

#import "CMainController.h"

#import "CXMLDocument.h"
#import "CXHTMLDocument.h"

@interface CMainController()
- (void)updateStatus;
@end


@implementation CMainController

@synthesize window;
@synthesize XMLString;
@synthesize XPath;
@synthesize status;
@synthesize documentType;

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

- (void)setDocumentType:(NSUInteger)aDocumentType
{
  if (aDocumentType != documentType)
  {
    documentType = aDocumentType;
    [self updateStatus];
  }
}

- (void)updateStatus
{
NSError *theError = NULL;
  CXMLDocument *theXMLDocument = nil;
  if (self.documentType == 0)
    theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:self.XMLString options:0 error:&theError] autorelease];
  else 
    theXMLDocument = [[[CXHTMLDocument alloc] initWithXHTMLString:self.XMLString options:0 error:&theError] autorelease];

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
		self.status = [NSString stringWithFormat:@"OK (root: %@)", theXMLDocument.rootElement];
	}
else
	{
	self.status = [NSString stringWithFormat:@"Error: %@", [theError description]];
	}

}

@end
