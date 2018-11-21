//
//  AccountInfoService.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfoService : NSObject

extern NSString *const BASE_URL;

@property NSString *productionAPIUrl;
@property NSString *devAPIUrl;
@property NSString *localhostUrl;
@property NSString *identifier;

- (NSString *)getAPIUrl;

@end
