//
//  Quote.h
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm.h>

@interface Quote : RLMObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSData *backgroundImageData;

- (instancetype)initWithQuote:(NSString *)quote author:(NSString *)author image:(UIImage *)image;

@end

