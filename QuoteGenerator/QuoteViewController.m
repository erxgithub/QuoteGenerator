//
//  QuoteViewController
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "QuoteViewController.h"
#import "MasterViewController.h"
#import "Quote.h"

@interface QuoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *quoteTextView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.savedQuotes = [@[] mutableCopy];
    // Do any additional setup after loading the view.
 
    
    
    [self setupQuote];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Action
- (IBAction)save:(UIButton *)sender {
  
  
  Quote *quote = [[Quote alloc] initWithQuote:self.quoteTextView.text
                                       author:self.authorLabel.text];
  [self.savedQuotes addObject:quote];
  
  // TODO: show saved alert dialog
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
  
  
  NSLog(@"saved quote.");
  for (Quote *quote in self.savedQuotes) {
      NSLog(@"saved quote: %@", quote.quoteText);
  }
}
- (IBAction)newQuote:(UIButton *)sender {
  [self setupQuote];
  [self.view setNeedsDisplay];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showQuotes"]) {
    MasterViewController *dvc = [segue destinationViewController];
    dvc.savedQuotes = self.savedQuotes;
  }
}


- (void) setupQuote {
  
  // Go to network for random quote and background image
    
    NSURL *url = [NSURL URLWithString:@"https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=10"];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    urlRequest.URL = url;
    [urlRequest addValue:@"b80vKNg6ETmshYheTwJh7uNaMGoVp1gYweSjsn2kX56aXJ9Ig2" forHTTPHeaderField:@"X-Mashape-Key"];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.waitsForConnectivity = YES;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSError *jsonError = nil;
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            // Handle JSON error
            NSLog(@"JSON error %@", jsonError.localizedDescription);
            return;
        }

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.quoteTextView.text = result[@"quote"];
            self.authorLabel.text = result[@"author"];
            [self.authorLabel sizeToFit];
            
            NSLog(@"%@", result);
        }];
    }];
    [dataTask resume];
    
}

@end
