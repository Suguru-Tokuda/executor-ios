//
//  UsersService.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "UsersService.h"
#import "AccountInfoService.h"

@implementation UsersService

- (instancetype) init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/users"];
    return self;
}

/* Beginning of request methods */
- (NSMutableURLRequest *)getUserRequest:(NSString *)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills {
    NSString *requestString = [NSString stringWithFormat:@"%@", self.endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
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
    NSString *skills = @"";
    for (NSString *skill in user.skills)
        skills = [NSString stringWithFormat: @"%@%@", skills, skill];
    NSString *bodyString = [NSString stringWithFormat:@"firstName=%@&lastName=%@&email=%@&username=%@&password=%@&skills=%@&picture%@&archived=%@&confirmed=%@",
                            user.firstName,
                            user.lastName,
                            user.email,
                            user.username,
                            user.password,
                            skills,
                            [NSString stringWithUTF8String:[user.picture bytes]],
                            [NSString stringWithFormat:@"%d", (user.archived == true ? 1 : 0)],
                            [NSString stringWithFormat:@"%d", (user.confirmed == true ? 1 : 0)]
                            ];
    NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)updateUserRequestWithUser:(EXCUser *)user {
    NSString *requestString = [NSString stringWithFormat:@"%@", _endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"PATCH"];
    [req setValue:user forKey:@"user"];
    return req;
}

- (NSMutableURLRequest *)getUserAvailabilityRequestWithEmail:(NSString *)email {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, @"/availability"];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:email forKey:@"email"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
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


/* This method returns a user object */
- (EXCUser *)getUserWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        NSLog(@"failed to serialize into JSON: %@", err);
    }
    NSMutableArray *tempSkills = nil;
    if (userDictionary[@"skills"] != (id)[NSNull null])
        tempSkills = [NSMutableArray arrayWithArray:[userDictionary[@"skills"] componentsSeparatedByString:@";"]];
    NSData *picture = (userDictionary[@"picture"] == (id)[NSNull null] ? nil : [userDictionary[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]);
    EXCUser *user = [[EXCUser alloc] initWithId:[userDictionary[@"userId"] longValue]
                                      firstName:userDictionary[@"firstName"]
                                       lastName:userDictionary[@"lastName"]
                                          email:userDictionary[@"email"]
                                       username:userDictionary[@"username"]
                                         skills:tempSkills
                                        picture:picture
                                           role:userDictionary[@"role"]];
    return user;
}

/* Returns the array of users */
- (NSMutableArray *)getUsersWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSArray *userDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        NSLog(@"failed to serialize into JSON: %@", err);
    }
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *userJson in userDictionary) {
        NSMutableArray *tempSkills = nil;
        if (userJson[@"skills"] != (id)[NSNull null])
            tempSkills = [NSMutableArray arrayWithArray:[userJson[@"skills"] componentsSeparatedByString:@";"]];
        NSData *picture = (userJson[@"picture"] == (id)[NSNull null] ? nil : [userJson[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]);
        EXCUser *user = [[EXCUser alloc] initWithId:[userJson[@"userId"] longValue]
                                          firstName:userJson[@"firstName"]
                                           lastName:userJson[@"lastName"]
                                              email:userJson[@"email"]
                                           username:@"username"
                                             skills:tempSkills
                                            picture:picture
                                               role:userJson[@"role"]];
        [users addObject: user];
    }
    return users;
}

@end

