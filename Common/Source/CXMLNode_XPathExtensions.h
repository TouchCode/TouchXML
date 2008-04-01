//
//  CXMLNode_XPathExtensions.h
//  TouchXML
//
//  Created by Jonathan Wight on 04/01/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "CXMLNode.h"

@interface CXMLNode (CXMLNode_XPathExtensions)

- (NSArray *)nodesForXPath:(NSString *)xpath namespaceMappings:(NSDictionary *)inNamespaceMappings error:(NSError **)error;

@end
