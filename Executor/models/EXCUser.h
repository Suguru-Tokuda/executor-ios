//
//  EXCUser.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCUser : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *email;
@property (nonatomic) NSMutableArray *skills;
@property (nonatomic) NSData *picture;
@property (nonatomic) NSString *role;
@property (nonatomic) NSArray *privileges;

- (instancetype) initWithFirstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                          username:(NSString *)username
                             email:(NSString *)email;

- (instancetype) initWithId:(NSString *)userId
                  firstName:(NSString *)firstName
                   lastName:(NSString *)lastName
                      email:(NSString *)email
                   username:(NSString *)username
                     skills:(NSMutableArray *)skills
                    picture:(NSData *)picture
                       role:(NSString *)role;

@end
