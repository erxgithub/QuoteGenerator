//
//  NetworkManager.h
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-08.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"

@interface NetworkManager : NSObject

+ (void)getQuoteDataCompletionHandler:(void (^)(Quote *))completion;
+ (void)getBackgroundImageCompletionHandler:(void (^)(UIImage *))completion;
@end
