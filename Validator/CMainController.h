//
//  CMainController.h
//  TouchXML
//
//  Created by Jonathan Wight on 03/18/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CMainController : NSObject {
	NSWindow *window;
	NSString *XMLString;
	NSString *XPath;
	NSString *status;
}

@property (readwrite, nonatomic, assign) IBOutlet NSWindow *window;
@property (readwrite, nonatomic, copy) NSString *XMLString;
@property (readwrite, nonatomic, copy) NSString *XPath;
@property (readwrite, nonatomic, copy) NSString *status;

@end
