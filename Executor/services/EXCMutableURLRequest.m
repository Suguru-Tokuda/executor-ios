//
//  EXCMutableURLRequest.m
//  Executor
//
//  Created by Suguru Tokuda on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCMutableURLRequest.h"

@implementation EXCMutableURLRequest

+ (NSMutableURLRequest *)requestWithURL:(NSURL *) url {
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appDelegate.token isEqualToString:@""])
        [req setValue:appDelegate.token forKey:@"Authorization"];
    return req;
}

@end
