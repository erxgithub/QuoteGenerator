//
//  Quote.h
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quote : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) UIImage *backgroundImage;

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author image:(UIImage *)image;

@end
