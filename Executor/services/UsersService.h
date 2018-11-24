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

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getUserRequest:(NSString *)userId;
- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills;
- (NSMutableURLRequest *)getUserAvailabilityRequestWithEmail:(NSString *)email;
- (NSMutableURLRequest *)createUserRequestWithUser:(EXCUser *)user;
- (NSMutableURLRequest *)updateUserRequestWithUser:(EXCUser *)user;
- (NSMutableURLRequest *)updateEmailRequestWithOldEmail:(NSString *)oldEmail newEmail:(NSString *)newEmail;
- (NSMutableURLRequest *)confirmUserRequestWithEmail:(NSString *)email;
- (NSMutableURLRequest *)archiveUserRequestWithUserId:(long)userId;
- (NSMutableURLRequest *)getUserRequestWithEmail:(NSString *)email;
- (EXCUser *)getUserWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getUsersWithJsonData:(NSData *)jsonData error:(NSError *)err;

@end
