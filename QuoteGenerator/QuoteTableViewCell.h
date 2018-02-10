//
//  QuoteTableViewCell.h
//  QuoteGenerator
//
//  Created by Eric Gregor on 2018-02-07.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quote.h"

@interface QuoteTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *quoteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbNailImageView;
@property (strong, nonatomic) Quote *quote;

@end
