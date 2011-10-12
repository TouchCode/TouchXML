//
//  CXMLNode_Debugging.m
//  TouchCode
//
//  Created by Jonathan Wight on 11/11/08.
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

#import "CXMLNode_Debugging.h"

@implementation CXMLNode (CXMLNode_Debugging)

- (void)dump
{
[self dumpNode:self->_node currentDepth:0];
}

- (void)dumpDoc:(xmlDocPtr)inNode currentDepth:(NSInteger)inDepth
{
}

- (void)dumpNode:(xmlNodePtr)inNode currentDepth:(NSInteger)inDepth
{
const int kWidth = 2;
char theSpaces[inDepth * kWidth + 1];
memset(theSpaces, ' ', inDepth * kWidth);
theSpaces[inDepth * kWidth] = 0x00;

printf("%sType: %d (%s)\n", theSpaces, inNode->type, [[self class] stringForNodeType:inNode->type]);
if (inNode->ns && inNode->ns != (xmlNsPtr)-1)
	{
	for (xmlNsPtr theNS = inNode->ns; theNS != NULL; theNS = theNS->next)
		[self dumpNS:theNS currentDepth:inDepth + 1];
	}

if (inNode->properties && inNode->properties != (struct _xmlAttr *)-1)
	{
	for (struct _xmlAttr *theAttribute = inNode->properties; theAttribute != NULL; theAttribute = theAttribute->next)
		[self dumpAttribute:theAttribute currentDepth:inDepth + 1];
	}


for (xmlNodePtr theChild = inNode->children; theChild != NULL; theChild = theChild->next)
	{
	[self dumpNode:theChild currentDepth:inDepth + 1];
	}
}

- (void)dumpNS:(xmlNsPtr)inNS currentDepth:(NSInteger)inDepth
{
const int kWidth = 2;
char theSpaces[inDepth * kWidth + 1];
memset(theSpaces, ' ', inDepth * kWidth);
theSpaces[inDepth * kWidth] = 0x00;

printf("%s NS: href:'%s' prefix:'%s'\n", theSpaces, inNS->href, inNS->prefix);
}

- (void)dumpAttribute:(xmlAttrPtr)inAttribute currentDepth:(NSInteger)inDepth
{
const int kWidth = 2;
char theSpaces[inDepth * kWidth + 1];
memset(theSpaces, ' ', inDepth * kWidth);
theSpaces[inDepth * kWidth] = 0x00;

printf("%s Attribute: %s", theSpaces, inAttribute->name);
}

+ (const char *)stringForNodeType:(int)inType
{
switch (inType)
	{
	case XML_ELEMENT_NODE:
		return("ELEMENT");
	case XML_ATTRIBUTE_NODE:
		return("ATTRIBUTE");
	case XML_TEXT_NODE:
		return("TEXT");
	case XML_CDATA_SECTION_NODE:
		return("CDATA");
	case XML_ENTITY_REF_NODE:
		return("ENTITY_REF");
	case XML_ENTITY_NODE:
		return("ENTITY");
	case XML_PI_NODE:
		return("PI");
	case XML_COMMENT_NODE:
		return("COMMENT");
	case XML_DOCUMENT_NODE:
		return("DOCUMENT");
	case XML_DOCUMENT_TYPE_NODE:
		return("DOCUMENT_TYPE");
	case XML_DOCUMENT_FRAG_NODE:
		return("DOCUMENT_FRAG");
	case XML_NOTATION_NODE:
		return("NOTATION_NODE");
	case XML_HTML_DOCUMENT_NODE:
		return("HTML_DOCUMENT_NODE");
	case XML_DTD_NODE:
		return("DTD_NODE");
	case XML_ELEMENT_DECL:
		return("ELEMENT_DECL");
	case XML_ATTRIBUTE_DECL:
		return("ATTRIBUTE_DECL");
	case XML_ENTITY_DECL:
		return("ENTITY_DECL");
	case XML_NAMESPACE_DECL:
		return("NAMESPACE_DECL");
	case XML_XINCLUDE_START:
		return("XINCLUDE_START");
	case XML_XINCLUDE_END:
		return("XINCLUDE_END");
	default:
		return("unknown");
	}
}

@end
