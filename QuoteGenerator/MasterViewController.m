//
//  MasterViewController.m
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "MasterViewController.h"
#import "QuoteTableViewCell.h"
#import "DetailViewController.h"
#import "QuoteViewController.h"
#import "QuoteView.h"
#import "NetworkManager.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) QuoteView *quoteView;
@property (nonatomic,) Quote *quote;
@end

@implementation MasterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.quote = [[Quote alloc] initWithQuote:@"" author:@"" image:nil];
  [self updateQuoteView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.quoteView = [[NSBundle mainBundle] loadNibNamed:@"QuoteView" owner:nil options:nil].firstObject;
  [self.view addSubview:self.quoteView];
  [self.view bringSubviewToFront:self.quoteView];
  
//  self.quoteView.QuoteTextView.text = self.quote.quoteText;
//  self.quoteView.authorLabel.text = self.quote.author;
//  self.quoteView.bgImageView.image = self.quote.backgroundImage;
  
  [self.quoteView.closeButton addTarget:self action:@selector(closeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.quoteView.quoteButton addTarget:self action:@selector(quoteTapped:) forControlEvents:UIControlEventTouchUpInside];
   }

- (void)closeTapped:(UIButton *)sender {
  [UIView animateWithDuration:0.3 animations:^{
    self.quoteView.alpha = 0.0;
  }];
}

- (void)quoteTapped:(UIButton *)sender {
    [self updateQuoteView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
//  QuoteViewController *quoteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QuoteViewController"];
//  [self presentViewController:quoteViewController animated:NO completion:nil];
}

- (void)viewDidLayoutSubviews {
  self.quoteView.frame = self.view.frame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.savedQuotes.count;
}


- (QuoteTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QuoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuoteCell" forIndexPath:indexPath];
  
  cell.quote = self.savedQuotes[indexPath.row];
  cell.quoteLabel.text = cell.quote.text;
  return cell;
}

#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *dvc = [segue destinationViewController];
        dvc.quote = self.savedQuotes[indexPath.row];
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.savedQuotes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Private methods
- (void)updateQuoteView {
  [self setupQuote];
  [self setupBackgroundImage];
  NSLog(@"%d, %@", __LINE__, self.quote);
}

- (void) setupQuote {
  [NetworkManager getQuoteDataCompletionHandler:^void(Quote *quote) {
    
    self.quoteView.quote = quote;
//    self.quote.quoteText = quote.quoteText;
//    self.quote.author = quote.author;
  }];
}

- (void)setupBackgroundImage {
  [NetworkManager getBackgroundImageCompletionHandler:^void(UIImage *image) {
    [self.quoteView setQuoteBackgroundImage:image];
  }];
}

@end
