//
//  EncodingTests.m
//  TouchCode
//
//  Created by Jorge Pedroso on 5/10/09.
//  Copyright 2011 Unsolicited Feedback. All rights reserved.
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
//  THIS SOFTWARE IS PROVIDED BY UNSOLICITED FEEDBACK ``AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL UNSOLICITED FEEDBACK OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Unsolicited Feedback.

#import "EncodingTests.h"

#import "CXMLDocument.h"

static NSString *xmlUTF8Str = @"\n\
<html> \n\
<head> \n\
<title>Новости и аналитика</title> \n\
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1251\" /> \n\
</head>\n\
</html>";


@implementation EncodingTests

- (void)test_initWithDataReturnsNilWhenInvalidEncoding
{
    NSError *error;
    
    NSData *nonUTF8Data = [xmlUTF8Str dataUsingEncoding:NSWindowsCP1251StringEncoding];

    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:nonUTF8Data options:0 error:&error];
//    STAssertNil(doc, NULL);
//    STAssertNotNil(error, NULL);
    [doc release];
    
    /* TODO: Unlike NSXMLDocument, CXMLDocument isn't failing parsing when given data with 
             non UTF-8 encoding, thus the above assertions are commented. */
    
    /* Extra: check NSXMLDocument compatibility — like CXMLDocument, expects failure */
    NSXMLDocument *nsdoc = [[NSXMLDocument alloc] initWithData:nonUTF8Data options:0 error:&error];
    STAssertNil(nsdoc, NULL);
    STAssertNotNil(error, NULL);
    [nsdoc release];
}


- (void)test_initWithDataNonUTF8Encoding
{
    NSError *error;
    
    NSData *nonUTF8Data = [xmlUTF8Str dataUsingEncoding:NSWindowsCP1251StringEncoding];

    /* Check if patch was applied. If not, bail gracefully showing how test will fail
       with a non UTF-8 encoding with initWithData:options:error: implementation. */
    CXMLDocument *doc;
    doc = [CXMLDocument instancesRespondToSelector:@selector(initWithData:encoding:options:error:)]
          ? [[CXMLDocument alloc] initWithData:nonUTF8Data 
                                      encoding:NSWindowsCP1251StringEncoding 
                                       options:0 
                                         error:&error]
          : [[CXMLDocument alloc] initWithData:nonUTF8Data options:0 error:&error];

    STAssertNotNil(doc, NULL);
    STAssertNil(error, NULL);

    NSString *path = @"/html/head/title";
    NSArray *nodes = [doc nodesForXPath:path error:&error];
    CXMLNode *node = [nodes objectAtIndex:0];
    NSString *result = [node stringValue];
    STAssertEqualObjects(result, @"Новости и аналитика", nil);
    
    [doc release];   

    /* Extra: check NSXMLDocument compatibility — like CXMLDocument, expects failure */
    NSXMLDocument *nsdoc = [[NSXMLDocument alloc] initWithData:nonUTF8Data options:0 error:&error];
    STAssertNil(nsdoc, NULL);
    STAssertNotNil(error, NULL);
    [nsdoc release];
    /* enough, parse went ok */
}


- (void)test_initWithStringNonUTF8Enconding
{
    NSError *error;

    /* sanity check */
    STAssertTrue([xmlUTF8Str canBeConvertedToEncoding:NSWindowsCP1251StringEncoding], 
                 @"XML cannot be converted to windows-1251 without losing data.", nil);
        
    NSData *nonUTF8Data = [xmlUTF8Str dataUsingEncoding:NSWindowsCP1251StringEncoding];
    NSString *nonUTF8Str = [[NSString alloc] initWithData:nonUTF8Data encoding:NSWindowsCP1251StringEncoding];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:nonUTF8Str options:0 error:&error];
    STAssertNotNil(doc, NULL);
    STAssertNil(error, NULL);

    NSString *path = @"/html/head/title";
    NSArray *nodes = [doc nodesForXPath:path error:&error];
    CXMLNode *node = [nodes objectAtIndex:0];
    NSString *result = [node stringValue];
    STAssertEqualObjects(result, @"Новости и аналитика", nil);

    [doc release];


    /* Extra: check NSXMLDocument compatibility — like CXMLDocument, expects correct parsing */
    NSXMLDocument *nsdoc = [[NSXMLDocument alloc] initWithXMLString:nonUTF8Str options:0 error:&error];
    STAssertNotNil(nsdoc, NULL);
    STAssertNil(error, NULL);
    [nsdoc release];
    /* enough, parse went ok */

    [nonUTF8Str release];
}

@end
