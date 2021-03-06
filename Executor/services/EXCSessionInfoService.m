//
//  AccountService.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCSessionInfoService.h"

@implementation EXCSessionInfoService

NSString *const BASE_URL = @"/Executor/api";
NSString *productionAPIUrl = @"";
NSString *devAPIUrl = @"";
NSString *localhostUrl = @"http";

- (NSString *)getAPIUrl {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSString *apiIdentifier = appDelegate.apiIdentifier;
    return ([apiIdentifier isEqualToString: @"production"] ? _productionAPIUrl : ([apiIdentifier isEqualToString: @"dev"] ? _devAPIUrl : _localhostUrl));
}

- (NSMutableURLRequest *)getLoginRequestWithEmail:(NSString *)email password:(NSString *)password {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/login"]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:email forKey:@"email"];
    [req setValue:password forKey:@"password"];
    [req setHTTPMethod:@"POST"];
    return req;
}

@end
