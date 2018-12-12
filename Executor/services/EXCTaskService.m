//
//  TaskService.m
//  Executor
//
//  Created by Suguru on 11/25/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCTaskService.h"

@implementation EXCTaskService

- (instancetype)init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/tasks"];
    return self;
}

/* Beginning of request methods */
- (NSMutableURLRequest *)getTasksRequestWithProjectId:(long)projectId userId:(long)userId {
    NSURL *url = [NSURL URLWithString:self.endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    NSString *bodyString = @"";
    if (projectId != 0)
        bodyString = [NSString stringWithFormat:@"projectId=%ld", projectId];
    if (userId != 0)
        bodyString = [NSString stringWithFormat:@"%@&userId=%ld", bodyString, userId];
    if (projectId != 0 || userId != 0) {
        NSData *postData = [bodyString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        [req setHTTPBody:postData];
    }
    return req;
}

- (NSMutableURLRequest *)getTaskRequestWithTaskId:(long)taskId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", _endPoint, taskId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    return req;
}

- (NSMutableURLRequest *)createTaskRequestWithTask:(EXCTask *) task {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSData *postData = [self getPostDataWithTask:task];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)updateTaskRequestWithTask:(EXCTask *) task {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"PATCH"];
    NSData *postData = [self getPostDataWithTask:task];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)deleteTaskRequestwithTaskId:(long) taskId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", _endPoint, taskId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}
/* End of request methods */

// -MARK: Post Data method
- (NSData *)getPostDataWithTask:(EXCTask *)task {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDictionary *jsonBodyDictionary = @{
                                         @"taskName":task.taskName,
                                         @"startDate":[dateFormatter stringFromDate:task.startDate],
                                         @"endDate":[dateFormatter stringFromDate:task.endDate],
                                         @"completed":[NSString stringWithFormat:@"%d", (task.completed == true ? 1: 0)],
                                         @"approved":[NSString stringWithFormat:@"%d", (task.approved == true ? 1: 0)],
                                         };
    if (task.taskId != 0) {
        [jsonBodyDictionary setValue:[NSString stringWithFormat:@"%ld", task.taskId] forKey:@"taskId"];
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDictionary options:kNilOptions error:nil];
    return postData;
}

// JSON parser methods
- (EXCTask *)getTaskWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *taskDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON:%@", err);
    EXCTask *task = [EXCTaskService getTaskWithDictionary:taskDictionary];
    return task;
}

- (NSMutableArray *)getTasksWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *taskDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON:%@", err);
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    for (NSDictionary *taskJson in taskDictionary) {
        EXCTask *task = [EXCTaskService getTaskWithDictionary:taskJson];
        [tasks addObject:task];
    }
    return tasks;
}

+ (EXCTask *)getTaskWithDictionary:(NSDictionary *)dictionary {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    EXCTask *task = [[EXCTask alloc] initWithTaskId:[dictionary[@"taskId"] longValue]
                                     taskName:dictionary[@"taskName"]
                                    startDate:[dateFormatter dateFromString:dictionary[@"startDate"]]
                                      endDate:[dateFormatter dateFromString:dictionary[@"endDate"]]
                                    completed:((int)dictionary[@"completed"] == 1 ? true : false)
                                     approved:((int)dictionary[@"approved"] == 1 ? true : false)
                                    projectId:[dictionary[@"project"][@"projectId"] longValue]
                                       userId:[dictionary[@"user"][@"userId"] longValue]
                     ];
    return task;
}

@end
