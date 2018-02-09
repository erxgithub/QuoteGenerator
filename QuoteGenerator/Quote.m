//
//  Quote.m
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "Quote.h"

@implementation Quote

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _text = quote;
        _author = author;
        _backgroundImageData = UIImageJPEGRepresentation(image, 1.0);
    }
    return self;
}

@end
