//
//  ProjectService.m
//  Executor
//
//  Created by Suguru on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "ProjectService.h"

@implementation ProjectService

- (instancetype)init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/projects"];
    return self;
}

- (NSMutableURLRequest *)getProjectsRequestWithUserId:(NSString *)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, (userId == nil ? @"" : [NSString stringWithFormat:@"%@%@", @"/", userId])];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)getProjectsRequestWithProjectId:(NSString *)projectId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", self.endPoint, @"/", projectId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)createProjectRequestWithUserId:(NSString *)userId  project:(EXCProject *)project {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", self.endPoint,  @"/", userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSString *bodyString = [NSString stringWithFormat:@"projectName=%@&startDate=%@&endDate=%@&completed=%@&picture=%@",
                            project.projectName,
                            project.startDate,
                            project.endDate,
                            [NSString stringWithFormat:@"%d", (project.completed == true ? 1 : 0)],
                            [NSString stringWithUTF8String:[project.picture bytes]]
                            ];
    NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [req setHTTPBody:postData];    
    return req;
}

- (NSMutableURLRequest *)deleteProjectRequestWithProjectId:(NSString *)projectId {
    return nil;
}

- (NSMutableURLRequest *)updateProjectRequest {
    return nil;
}

@end
