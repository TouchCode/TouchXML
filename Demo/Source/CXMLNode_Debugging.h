//
//  CXMLNode_Debugging.h
//  TouchXML
//
//  Created by Jonathan Wight on 11/11/08.
//  Copyright 2008 toxicsoftware.com. All rights reserved.
//

#import "CXMLNode.h"

@interface CXMLNode (CXMLNode_Debugging)

- (void)dump;
- (void)dumpNode:(xmlNodePtr)inNode currentDepth:(NSInteger)inDepth;
- (void)dumpNS:(xmlNsPtr)inNS currentDepth:(NSInteger)inDepth;
- (void)dumpAttribute:(xmlAttrPtr)inNS currentDepth:(NSInteger)inDepth;

+ (const char *)stringForNodeType:(int)inType;

@end
