//
//  ProjectService.m
//  Executor
//
//  Created by Suguru on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCProjectService.h"

@implementation EXCProjectService

- (instancetype)init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/projects"];
    return self;
}

// -MARK: Request methods
- (NSMutableURLRequest *)getProjectsRequestWithUserId:(long)userId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", self.endPoint, (userId == 0 ? @"" : [NSString stringWithFormat:@"/%ld", userId])];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    return req;
}

- (NSMutableURLRequest *)getProjectsRequestWithProjectId:(long)projectId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", self.endPoint, projectId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    return req;
}

- (NSMutableURLRequest *)createProjectRequestWithUserId:(long)userId  project:(EXCProject *)project {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", self.endPoint, userId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSData *postData = [self getPostDataWithProject:project];
    [req setHTTPBody:postData];    
    return req;
}

- (NSMutableURLRequest *)deleteProjectRequestWithProjectId:(long)projectId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", self.endPoint, projectId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}

- (NSMutableURLRequest *)updateProjectRequestWithProject:(EXCProject *)project {
    NSURL *url = [NSURL URLWithString:self.endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    NSData *postData = [self getPostDataWithProject:project];
    [req setHTTPBody:postData];
    [req setHTTPMethod:@"PATCH"];
    return req;
}

// -MARK: Post data method
- (NSData *)getPostDataWithProject:(EXCProject *)project {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDictionary *jsonBodyDictionary = @{
                                         @"projectName":project.projectName,
                                         @"startDate":[dateFormatter stringFromDate:project.startDate],
                                         @"endDate":[dateFormatter stringFromDate:project.endDate],
                                         @"completed":[NSString stringWithFormat:@"%d", (project.completed == true ? 1 : 0)],
                                         @"picture":(project.picture == nil ? [NSNull null] : [NSString stringWithUTF8String:[project.picture bytes]])};;
    if (project.projectId != 0) {
        [jsonBodyDictionary setValue:[NSString stringWithFormat:@"%ld", project.projectId] forKey:@"projectId"];
    }
   NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDictionary options:kNilOptions error:nil];
    return postData;
}

// -MARK: JSON parser methods
/* Returns a project object */
- (EXCProject *)getProjectWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *projectDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"Failed to serialize into JSON: %@", err);
    EXCProject *project = [EXCProjectService getProjectWithDictionary:projectDictionary];
    return project;
}

/* Returns an array of projects */
- (NSMutableArray *)getProjectsWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSArray *projectDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON: %@", err);
    NSMutableArray *projects = [[NSMutableArray alloc] init];
    for (NSDictionary *projectJSON in projectDictionary) {
        EXCProject *project = [EXCProjectService getProjectWithDictionary:projectJSON];
        [projects addObject:project];
    }
    return projects;
}

/* A class method that returns EXCProject object for the parameter dictionary */
+ (EXCProject *)getProjectWithDictionary:(NSDictionary *)dictionary {
    NSData *picture = (dictionary[@"picture"] == (id)[NSNull null] ? nil : [dictionary[@"picture"] dataUsingEncoding:NSUTF8StringEncoding]);
    EXCProject *project = [[EXCProject alloc] initWithTaskId:[dictionary[@"projejctId"] longValue]
                                             projectName:dictionary[@"projectName"]
                                               startDate:dictionary[@"startData"]
                                                 endDate:dictionary[@"endDate"]
                                                 picture:picture
                                                   tasks:nil
                                               completed:((int)dictionary[@"completed"] == 1 ? true : false)];
    return project;
}

@end
