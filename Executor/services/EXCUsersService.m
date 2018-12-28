//
//  UsersService.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCUsersService.h"

@implementation EXCUsersService

- (instancetype) init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/users"];
    return self;
}

/* Beginning of request methods */
- (NSMutableURLRequest *)getUserRequest:(long)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", self.endPoint, userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    return req;
}

- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills {
    NSString *requestString = [NSString stringWithFormat:@"%@", self.endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    NSString *bodyString = [NSString stringWithFormat:@"email=%@&firstName=%@&lastName=%@&skills=%@", email, firstName, lastName, skills];
    NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)createUserRequestWithUser:(EXCUser *)user {
    NSString *requestString = [NSString stringWithFormat:@"%@", _endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSData *postData = [self getPostDataWithUser:user];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)updateUserRequestWithUser:(EXCUser *)user {
    NSString *requestString = [NSString stringWithFormat:@"%@", _endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"PATCH"];
    [req setValue:user forKey:@"user"];
    NSData *postData = [self getPostDataWithUser:user];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)getUserAvailabilityRequestWithEmail:(NSString *)email {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/availability"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:email forKey:@"email"];
    return req;
}

- (NSMutableURLRequest *)updateEmailRequestWithOldEmail:(NSString *)oldEmail newEmail:(NSString *)newEmail {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/updateEmail"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:newEmail forKey:@"newEmail"];
    [req setValue:oldEmail forKey:@"oldEmail"];
    return req;
}

- (NSMutableURLRequest *)confirmUserRequestWithEmail:(NSString *)email {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/confirm"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:email forKey:@"email"];
    return req;
}
                               
- (NSMutableURLRequest *)archiveUserRequestWithUserId:(long)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/confirm"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:[NSString stringWithFormat:@"%ld", userId] forKey:@"userId"];
    return req;
}
                               
- (NSMutableURLRequest *)getUserRequestWithEmail:(NSString *)email {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/findByEmail"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:email forKey:@"email"];
    return req;
}

/* End of request methods */

// -MARK: Post data method
/* Returns the post data */
- (NSData *)getPostDataWithUser:(EXCUser *)user {
    NSString *skills = @"";
    if (sizeof(skills) > 0) {
        for (NSString *skill in user.skills)
            skills = [NSString stringWithFormat: @"%@%@", skills, skill];
    }
    NSDictionary *jsonBodyDictionary = @{@"firstName":user.firstName, @"lastName":user.lastName, @"email":user.email, @"username":user.username, @"skills":skills, @"picture":[NSString stringWithUTF8String:[user.picture bytes]], @"archived":[NSString stringWithFormat:@"%d", (user.archived == true ? 1 : 0)], @"confirmed":[NSString stringWithFormat:@"%d", (user.confirmed == true ? 1 : 0)]};
    if (user.userId != 0) {
        [jsonBodyDictionary setValue:[NSString stringWithFormat:@"%ld", user.userId] forKey:@"userId"];
    } else {
        [jsonBodyDictionary setValue:user.password forKey:@"password"];
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDictionary options:kNilOptions error:nil];
    return postData;
}

/* This method returns a user object */
- (EXCUser *)getUserWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON: %@", err);
    EXCUser *user = [EXCUsersService getUserWithUserDictionary:userDictionary];
    if ([userDictionary[@"projects"] length] > 0) {
        NSArray *projects = userDictionary[@"projects"];
        for (NSDictionary *projectJSON in projects) {
            EXCProject *project = [EXCProjectService getProjectWithDictionary:projectJSON];
            [user.projects addObject:project];
        }
    } else {
        user.projects = [[NSMutableArray alloc] init];
    }
    
    if ([userDictionary[@"tasks"] length] > 0) {
        NSArray *tasks = userDictionary[@"tasks"];
        for (NSDictionary *taskJSON in tasks) {
            EXCTask *task = [EXCTaskService getTaskWithDictionary:taskJSON];
            [user.tasks addObject:task];
        }
    } else {
        user.tasks = [[NSMutableArray alloc] init];
    }
    
    if ([userDictionary[@"authorities"] length] > 0) {
        NSArray *authorities = userDictionary[@"authorities"];
        for (NSDictionary *authJSON in authorities) {
            EXCAuthority *authority = [EXCAuthorityService getAuthorityWithAuthorityDictionary:authJSON];
            [user.authorities addObject:authority];
        }
    }
    
    return user;
}

/* Returns an array of users */
- (NSMutableArray *)getUsersWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSArray *userDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON:%@", err);
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *userJson in userDictionary) {
        EXCUser *user = [EXCUsersService getUserWithUserDictionary:userJson];
        [users addObject:user];
    }
    return users;
}

+ (EXCUser *)getUserWithUserDictionary:(NSDictionary *)userDictionary {
    NSMutableArray *tempSkills = nil;
    if (userDictionary[@"skills"] != (id)[NSNull null])
        tempSkills = [NSMutableArray arrayWithArray:[userDictionary[@"skills"] componentsSeparatedByString:@";"]];
    NSData *picture = (userDictionary[@"picture"] == (id)[NSNull null] ? nil : [userDictionary[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]);
    EXCUser *user = [[EXCUser alloc] initWithUserId:[userDictionary[@"userId"] longValue]
                                          firstName:userDictionary[@"firstName"]
                                           lastName:userDictionary[@"lastName"]
                                              email:userDictionary[@"email"]
                                           username:userDictionary[@"username"]
                                             skills:tempSkills
                                            picture:picture
                                               role:userDictionary[@"role"]];
    return user;
}

@end

