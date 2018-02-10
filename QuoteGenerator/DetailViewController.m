//
//  DetailViewController.m
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *blurHeightContraint;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.quoteLabel.text = self.quote.text;
    self.authorLabel.text = self.quote.author;
    self.bgImageView.image = [UIImage imageWithData:self.quote.backgroundImageData];
    [self.authorLabel sizeToFit];
 
}

- (void)viewDidLayoutSubviews {
    self.blurHeightContraint.constant = self.quoteLabel.frame.size.height + self.authorLabel.frame.size.height + 50;
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareButton:(UIButton *)sender {
    [self.blurView setHidden:YES];
    //takes screenshot
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.blurView setHidden:NO];
    
    //Share quote
  
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[capturedScreen]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end
