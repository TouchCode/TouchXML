//
//  CXMLNode_FilteredAttributesExtensions.m
//  TouchCode
//
//  Created by Felix Morgner on 11/01/11.
//  Copyright 2011 felixmorgner.ch. All rights reserved.
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

#import "CXMLNode_FilteredAttributesExtensions.h"
#import "CXMLNode_PrivateExtensions.h"

@implementation CXMLNode (CXMLNode_FilteredAttributesExtensions)

- (NSArray *)childrenOfKind:(CXMLNodeKind)theKind
	{
	NSAssert(_node != NULL, @"CXMLNode does not have attached libxml2 _node.");
	
	NSMutableArray *theChildren = [NSMutableArray array];
	
	if (_node->type != CXMLAttributeKind) // NSXML Attribs don't have children.
		{
		xmlNodePtr theCurrentNode = _node->children;

		while (theCurrentNode != NULL)
			{
			while(theCurrentNode && theCurrentNode->type != theKind)
				theCurrentNode = theCurrentNode->next;
				
			if(!theCurrentNode)
				break;

			CXMLNode *theNode = [CXMLNode nodeWithLibXMLNode:theCurrentNode freeOnDealloc:NO];
			[theChildren addObject:theNode];
			theCurrentNode = theCurrentNode->next;
			}
		}
	return(theChildren);      
	}

@end
