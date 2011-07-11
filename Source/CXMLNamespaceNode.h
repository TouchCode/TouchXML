//
//  CXMLNamespaceNode.h
//  TouchXML
//
//  Created by Jonathan Wight on 1/1/2000.
//  Copyright 2011 toxicsoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXMLNode.h"
#import "CXMLElement.h"

@interface CXMLNamespaceNode : CXMLNode {

	NSString *_prefix;
	NSString *_uri;
	CXMLElement *_parent;
}

- (id) initWithPrefix:(NSString *)prefix URI:(NSString *)uri parentElement:(CXMLElement *)parent;

@end
