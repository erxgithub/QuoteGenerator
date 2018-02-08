//
//  QuoteView.m
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-08.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "QuoteView.h"
#import "Quote.h"

@interface QuoteView()
@property (strong, nonatomic) IBOutlet UITextView *QuoteTextView;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
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
  
  dispatch_async(dispatch_get_main_queue(), ^{
    self.QuoteTextView.text = quote.text;
    self.authorLabel.text = quote.author;
  
  
    [UIView animateWithDuration:0.3 animations:^{
      self.alpha = 0.0;
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
//    [self setNeedsDisplay];
    
  });

}

@end
