//
//  User.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCUser.h"

@implementation EXCUser

- (instancetype) initWithFirstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                          username:(NSString *)username
                             email:(NSString *)email {
    self = [super init];
    self.firstName = firstName;
    self.lastName = lastName;
    self.username = username;
    self.email = email;
    return self;
}

- (instancetype) initWithId:(NSString *)userId
                  firstName:(NSString *)firstName
                   lastName:(NSString *)lastName
                      email:(NSString *)email
                   username:(NSString *)username
                     skills:(NSMutableArray *)skills
                    picture:(NSData *)picture
                       role:(NSString *)role {
    self = [super init];
    self.userId = userId;
    self.firstName = firstName;
    self.lastName = lastName;
    self.email = email;
    self.username = username;
    self.picture = picture;
    self.role = role;
    return self;
}



@end
