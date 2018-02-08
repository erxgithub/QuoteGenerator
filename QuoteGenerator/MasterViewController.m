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

@interface MasterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.savedQuotes.count;
}


- (QuoteTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QuoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuoteCell" forIndexPath:indexPath];
  
  cell.quote = self.savedQuotes[indexPath.row];
  cell.quoteLabel.text = cell.quote.quoteText;
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

@end
