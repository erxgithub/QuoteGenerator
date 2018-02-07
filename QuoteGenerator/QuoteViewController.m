//
//  MasterViewController.m
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "QuoteViewController.h"
#import "Quote.h"

@interface QuoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (nonatomic, strong) Quote *quote;

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.quote = [[Quote alloc] initWithQuote:@"This is a great quote." author:@"Some Guy"];
    
    [self setupQuote];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setupQuote {
    self.quoteTextView.text = self.quote.quoteText;
    self.authorLabel.text = self.quote.author;
    [self.authorLabel sizeToFit];
}

@end
