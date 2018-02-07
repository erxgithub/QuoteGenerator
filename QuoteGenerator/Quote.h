//
//  Quote.h
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject

@property (nonatomic, strong) NSString *quoteText;
@property (nonatomic, strong) NSString *author;

- (instancetype)initWithQuote: (NSString *)quote author: (NSString *)author;

@end
