//
//  TaskService.m
//  Executor
//
//  Created by Suguru on 11/25/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "TaskService.h"

@implementation TaskService

- (instancetype)init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/tasks"];
    return self;
}

/* Beginning of request methods */
- (NSMutableURLRequest *)getTasksRequestWithProjectId:(NSString *)projectId userId:(NSString *)userId {
    NSURL *url = [NSURL URLWithString:self.endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    NSString *bodyString = @"";
    if (projectId != nil)
        bodyString = [NSString stringWithFormat:@"projectId=%@", projectId];
    if (userId != nil)
        bodyString = [NSString stringWithFormat:@"%@&userId=%@", bodyString, userId];
    if (projectId != nil || userId != nil) {
        NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [req setHTTPBody:postData];
    }
    return req;
}

- (NSMutableURLRequest *)getTaskRequestWithTaskId:(NSString *)taskId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", _endPoint, @"/", taskId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Accept"];
    return req;
}

- (NSMutableURLRequest *)createTaskRequestWithTask:(EXCTask *) task {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [self getPostDataWithTask:task];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)updateTaskRequestWithTask:(EXCTask *) task {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"PATCH"];
    [req setValue:@"application-json" forHTTPHeaderField:@"Content-Type"];
    NSData *postData = [self getPostDataWithTask:task];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)deleteTaskRequestwithTaskId:(NSString *) taskId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@", _endPoint, @"/", taskId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}
/* End of request methods */

- (NSData *)getPostDataWithTask:(EXCTask *)task {
    NSString *bodyString = [NSString stringWithFormat:@"taskName=%@&startDate=%@&endDate=%@&completed=%@&approved=%@&projecdtId=%@&userId=%@",
                            task.taskName,
                            task.startDate,
                            task.endDate,
                            [NSString stringWithFormat:@"%d", (task.completed == true ? 1: 0)],
                            [NSString stringWithFormat:@"%d", (task.approved == true ? 1: 0)],
                            (task.projectId == nil ? [NSNull null] : task.projectId),
                            (task.userId == nil ? [NSNull null] : task.userId)
                            ];
    NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    return postData;
}

@end
