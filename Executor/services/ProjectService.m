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

/* Beginning of request methods */
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
    [req setValue:@"application-json" forHTTPHeaderField:@"Content-Type"];
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
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, projectId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}

- (NSMutableURLRequest *)updateProjectRequestWithProject:(EXCProject *)project {
    NSURL *url = [NSURL URLWithString:self.endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    NSString *bodyString = [NSString stringWithFormat:@"projectId=%@&projectName=%@&startDate=%@&endDate=%@&completed=%@&picture=%@",
                            [NSString stringWithFormat:@"%ld", project.projectId],
                            project.projectName,
                            project.startDate,
                            project.endDate,
                            [NSString stringWithFormat:@"%d", (project.completed == true ? 1 : 0)],
                            (project.picture == nil ? [NSNull null] : [NSString stringWithUTF8String:[project.picture bytes]])
                            ];
    NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [req setHTTPBody:postData];
    [req setHTTPMethod:@"PATCH"];
    return req;
}

/* End of request methods */

/* Returns a project object */
- (EXCProject *)getProjectWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *projectDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"Failed to serialize into JSON: %@", err);
    EXCProject *project = [ProjectService getProjectWithDictionary:projectDictionary];
    return project;
}

/* Returns an array of projects */
- (NSMutableArray *)getProjectsWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSArray *projectDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON: %@", err);
    NSMutableArray *projects = [[NSMutableArray alloc] init];
    for (NSDictionary *projectJSON in projectDictionary) {
        EXCProject *project = [ProjectService getProjectWithDictionary:projectJSON];
        [projects addObject:project];
    }
    return projects;
}

/* A class method that returns EXCProject object for the parameter dictionary */
+ (EXCProject *)getProjectWithDictionary:(NSDictionary *)dictionary {
    NSData *picture = (dictionary[@"picture"] == (id)[NSNull null] ? nil : [dictionary[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]);
    EXCProject *project = [[EXCProject alloc] initWithId:[dictionary[@"projejctId"] longValue]
                                             projectName:dictionary[@"projectName"]
                                               startDate:dictionary[@"startData"]
                                                 endDate:dictionary[@"endDate"]
                                                 picture:picture
                                                   tasks:nil
                                               completed:([dictionary[@"completed"] isEqualToString:@"1"] ? true : false)];
    return project;
}

@end
