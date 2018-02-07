//
//  Quote.m
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "Quote.h"

@implementation Quote

- (instancetype)initWithQuote: (NSString *)quote author: (NSString *)author;
{
    self = [super init];
    if (self) {
        _quoteText = quote;
        _author = author;
    }
    return self;
}

@end
