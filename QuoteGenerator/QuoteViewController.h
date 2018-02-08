//
//  MasterViewController.h
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quote.h"

@interface QuoteViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<Quote *> *savedQuotes;

@end
