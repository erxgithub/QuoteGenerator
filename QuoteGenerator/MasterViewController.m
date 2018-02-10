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
#import "QuoteView.h"
#import "NetworkManager.h"

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (nonatomic) QuoteView *quoteView;
@property (nonatomic,) Quote *quote;

@end

@implementation MasterViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // load from realm
        self.savedQuotes = [@[] mutableCopy];
        RLMResults<Quote *> *quotes = [Quote allObjects];
        //RLMRealm *realm = [RLMRealm defaultRealm];
        for (Quote *quote in quotes) {
            [self.savedQuotes addObject:quote];
        }
    }

    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateQuoteView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.quoteView = [[NSBundle mainBundle] loadNibNamed:@"QuoteView" owner:nil options:nil].firstObject;
  [self.view addSubview:self.quoteView];
  [self.view bringSubviewToFront:self.quoteView];
  
  [self.quoteView.closeButton addTarget:self action:@selector(closeTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.quoteView.quoteButton addTarget:self action:@selector(quoteTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.quoteView.saveButton addTarget:self action:@selector(saveTapped:) forControlEvents:UIControlEventTouchUpInside];
   }

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
  self.quoteView.frame = self.view.frame;
    [self.quoteView setBlurViewHeight];
}


#pragma mark - QuoteView buttons actions
- (void)closeTapped:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.quoteView.alpha = 0.0;
    }];
}

- (void)quoteTapped:(UIButton *)sender {
    [self updateQuoteView];
}

- (void)saveTapped:(UIButton *)sender {
  [self.quoteView saveViewContentToQuote];
  [self.savedQuotes addObject:self.quoteView.quote];
    
    // write to realm
    // Persist your data easily
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:self.quoteView.quote];
    }];

    [self.tableView reloadData];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Saved" message:@"Quote saved"                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

# pragma mark - tableView button actions
- (IBAction)closeTableView:(id)sender {
    [self updateQuoteView];
    [UIView animateWithDuration:0.3 animations:^{
        self.quoteView.alpha = 1.0;
    }];
}

- (IBAction)toggleTableEdit:(id)sender {
    if ([self.editButton.titleLabel.text  isEqual: @"Edit"]) {
        [self.tableView setEditing:YES animated:YES];
        
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.editButton setTitle:@"Done" forState:UIControlStateSelected];
        [self.editButton setTitle:@"Done" forState:UIControlStateHighlighted];
    } else {
        [self.tableView setEditing:NO animated:YES];
        
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.editButton setTitle:@"Edit" forState:UIControlStateSelected];
        [self.editButton setTitle:@"Edit" forState:UIControlStateHighlighted];
    }
}

# pragma mark - tableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.savedQuotes.count;
}

- (QuoteTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QuoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuoteCell" forIndexPath:indexPath];
  
  cell.quote = self.savedQuotes[indexPath.row];
  cell.quoteLabel.text = cell.quote.text;
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        Quote* quote = self.savedQuotes[indexPath.row];
        [realm deleteObject:quote];
        [self.savedQuotes removeObjectAtIndex:indexPath.row];
        [realm commitWriteTransaction];
        //[self.savedQuotes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // delete from realm
        
    }
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

#pragma mark - Private methods
- (void)updateQuoteView {
  [self setupQuote];
  [self setupBackgroundImage];
}

#pragma mark - New Quote
- (void) setupQuote {
  [NetworkManager getQuoteDataCompletionHandler:^void(Quote *quote) {
//    self.quoteView.quote = [[Quote alloc] initWithQuote:quote];
    self.quoteView.quote = quote;
  }];
}

- (void)setupBackgroundImage {
  [NetworkManager getBackgroundImageCompletionHandler:^void(UIImage *image) {
    [self.quoteView setQuoteBackgroundImage:image];
  }];
}

@end
