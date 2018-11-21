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

@interface UsersService : NSObject

@property (nonatomic, readonly) NSString *endPoint;

- (EXCUser *)getUser:(NSString *)userId;
- (NSArray *)getUsersWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills;

@end
