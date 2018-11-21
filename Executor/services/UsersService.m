//
//  UsersService.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "UsersService.h"
#import "AccountInfoService.h"

@implementation UsersService

NSString *endPoijnt = @"users/";

- (NSMutableURLRequest *)getUserRequest:(NSString *)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", BASE_URL, self.endPoint, userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", BASE_URL, self.endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"email" forKey:email];
    [req setValue:@"firstName" forKey:firstName];
    [req setValue:@"lastName" forKey:lastName];
    [req setValue:@"skills" forKey:skills];
    return req;
}

@end
