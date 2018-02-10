//
//  QuoteView.m
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-08.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "QuoteView.h"


@interface QuoteView()

@property (strong, nonatomic) IBOutlet UILabel *quoteLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *blurHeightConstraint;

@end

@implementation QuoteView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.alpha = 0.0;
  }
  return self;
}

// make this just handle the text
- (void)setQuote:(Quote *)quote {
  // setup your outlets
  _quote = quote;
  dispatch_async(dispatch_get_main_queue(), ^{
    //    self.QuoteTextView.text = quote.text;
    self.quoteLabel.text = quote.text;
    [self.quoteLabel sizeToFit];
    self.authorLabel.text = quote.author;
    [self.authorLabel sizeToFit];
    
    [UIView animateWithDuration:0.3 animations:^{
      self.alpha = 1.0;
    }];
  });
}

// create a parallel method to handle the image request
- (void)setQuoteBackgroundImage:(UIImage *)image
{
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.bgImageView.image = image;
    
    [UIView animateWithDuration:0.3 animations:^{
      self.alpha = 1.0;
    }];
    
  });
}

- (void)saveViewContentToQuote
{
  self.quote = [[Quote alloc] initWithQuote:self.quoteLabel.text
                                     author:self.authorLabel.text
                                      image:self.bgImageView.image];
}

- (void)setBlurViewHeight {
    self.blurHeightConstraint.constant = self.quoteLabel.frame.size.height + self.authorLabel.frame.size.height + 50;
}

@end
