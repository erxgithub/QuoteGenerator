//
//  DetailViewController.m
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.quoteTextView.text = self.quote.text;
    self.authorLabel.text = self.quote.author;
    self.bgImageView.image = [UIImage imageWithData:self.quote.backgroundImageData];
    [self.authorLabel sizeToFit];

}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
