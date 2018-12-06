//
//  EXCUser.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCUser : NSObject

@property (nonatomic) long userId;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *password;
@property (nonatomic) NSMutableArray *skills;
@property (nonatomic) NSData *picture;
@property (nonatomic) NSString *role;
@property (nonatomic) NSArray *privileges;
@property (nonatomic) Boolean archived;
@property (nonatomic) Boolean confirmed;

@property (nonatomic) NSMutableArray *projects;
@property (nonatomic) NSMutableArray *authorities;

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName username:(NSString *)username email:(NSString *)email;
- (instancetype)initWithId:(long)userId firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email username:(NSString *)username skills:(NSMutableArray *) skills picture:(NSData *)picture role:(NSString *)role;

@end
