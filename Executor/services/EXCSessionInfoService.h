//
//  AccountInfoService.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "EXCMutableURLRequest.h"

@interface EXCSessionInfoService : NSObject

extern NSString *const BASE_URL;
@property (nonatomic) NSString *productionAPIUrl;
@property (nonatomic) NSString *devAPIUrl;
@property (nonatomic) NSString *localhostUrl;

- (NSString *)getAPIUrl;
- (NSMutableURLRequest *)getLoginRequestWithEmail:(NSString *)email password:(NSString *)password;

@end
