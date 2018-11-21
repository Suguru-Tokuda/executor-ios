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

NSString *endPoijnt = @"users/";

- (NSMutableURLRequest *)getUserRequest:(NSString *)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", BASE_URL, self.endPoint, userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)getUsersRequestWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName skills:(NSString *)skills {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", BASE_URL, self.endPoint];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    [req setValue:@"email" forKey:email];
    [req setValue:@"firstName" forKey:firstName];
    [req setValue:@"lastName" forKey:lastName];
    [req setValue:@"skills" forKey:skills];
    return req;
}

/* This method returns a user object */
- (EXCUser *)getUserWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err) {
        NSLog(@"failed to serialize into JSON: %@", err);
    }
    NSMutableArray *tempSkills = [NSMutableArray arrayWithArray:[userDictionary[@"skills"] componentsSeparatedByString:@";"]];
    EXCUser *user = [[EXCUser alloc] initWithId:userDictionary[@"userId"]
                                      firstName:userDictionary[@"firstName"]
                                       lastName:userDictionary[@"lastName"]
                                          email:userDictionary[@"email"]
                                       username:userDictionary[@"username"]
                                         skills:tempSkills
                                        picture:(NSData *)[userDictionary[@"picture"] dataUsingEncoding:NSUTF8StringEncoding] role:userDictionary[@"role"]];
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
        NSMutableArray *tempSkills = [NSMutableArray arrayWithArray:[userJson[@"skills"] componentsSeparatedByString:@";"]];
        EXCUser *user = [[EXCUser alloc] initWithId:userJson[@"userId"]
                                          firstName:userJson[@"firstName"]
                                           lastName:userJson[@"lastName"]
                                              email:userJson[@"email"]
                                           username:@"username"
                                             skills:tempSkills
                                            picture:(NSData *)[userJson[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]
                                               role:userJson[@"role"]];
        [users addObject: user];
    }
    return users;
}

@end
