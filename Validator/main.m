//
//  main.m
//  TouchXML
//
//  Created by Jonathan Wight on 03/18/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import <AppKit/AppKit.h>

int main(int argc, const char *argv[])
{
NSAutoreleasePool *thePool = [[NSAutoreleasePool alloc] init];

NSApplicationMain(argc, argv);

[thePool drain];

return(0);
}