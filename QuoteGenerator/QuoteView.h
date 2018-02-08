//
//  QuoteView.h
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-08.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Quote;

@interface QuoteView : UIView
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *quoteButton;

@property (nonatomic) Quote *quote;

- (void)setQuoteBackgroundImage:(UIImage *)image;
@end