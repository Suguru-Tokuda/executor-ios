//
//  AccountService.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "AccountInfoService.h"

@interface AccountInfoService ()

@end

@implementation AccountInfoService

NSString *const BASE_URL = @"/Executor/api";

- (NSString *)getAPIUrl {
    return ([_identifier isEqualToString: @"production"] ? _productionAPIUrl : ([_identifier isEqualToString: @"dev"] ? _devAPIUrl : _localhostUrl));
}

@end
