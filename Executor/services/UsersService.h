//
//  UsersService.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCUser.h"
#import "AccountInfoService.h"
#import "EXCMutableURLRequest.h"

@interface UsersService : NSObject

@property (nonatomic, readonly) NSString *endPoint;

- (NSMutableURLRequest *)getUserRequest:(NSString *)userId;
- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills;

@end
