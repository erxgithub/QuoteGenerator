//
//  NetworkManager.m
//  QuoteGenerator
//
//  Created by Yongwoo Huh on 2018-02-08.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

#import "NetworkManager.h"
#import "Quote.h"
@import UIKit;

@implementation NetworkManager

+ (void)getQuoteDataCompletionHandler:(void (^)(Quote *))completion
{
  
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
    Quote *quote = [[Quote alloc] initWithQuote:result[@"quote"]
                                         author:result[@"author"]
                                          image:nil];
    completion(quote);
    [session invalidateAndCancel];
  }];
  [dataTask resume];
}


+ (void)getBackgroundImageCompletionHandler:(void (^)(UIImage *))completion
{
  NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=f71ef240962b89ee62eb2a63d8524fe9&tags=landscape"];
  NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.waitsForConnectivity = YES;
  configuration.allowsCellularAccess = NO;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
    if (error) {
      // Handle the error
      NSLog(@"error: %@", error.localizedDescription);
      return;
    }
    NSError *jsonError = nil;
    
    NSArray *backgroundImages  = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError][@"photos"][@"photo"];
    
    if (jsonError) {
      // Handle JSON error
      NSLog(@"JSON error %@", jsonError.localizedDescription);
      return;
    }
    
    NSMutableArray<NSString *> *urls = [@[] mutableCopy];
    for (NSDictionary* bgI in backgroundImages) {
      NSString* url = [self makeURLWithFarm:bgI[@"farm"] Server:bgI[@"server"] ID:bgI[@"id"] Secret:bgI[@"secret"]];
      [urls addObject:url];
    }
    
    // get a random url
    NSUInteger index = arc4random_uniform(urls.count - 1);
    NSString *imageURL = urls[index];
    UIImage *image = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:
                       [NSURL URLWithString:imageURL]]];
    
    
    completion(image);
    [session invalidateAndCancel];
    
  }];
  [dataTask resume];
}

+ (NSString *)makeURLWithFarm:(NSString *)farm Server:(NSString *)server ID:(NSString *)idNum Secret:(NSString *)secret
{
  return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, idNum, secret];
}

@end
