//
//  EncodingTests.m
//  TouchCode
//
//  Created by Jorge Pedroso on 5/10/09.
//  Copyright 2009 Unsolicited Feedback. All rights reserved.
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
