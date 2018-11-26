//
//  TaskService.h
//  Executor
//
//  Created by Suguru on 11/25/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCTask.h"

@interface TaskService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getTasksRequestWithProjectId:(NSString *)projectId userId:(NSString *)userId;
- (NSMutableURLRequest *)getTaskRequestWithTaskId:(NSString *)taskId;
- (NSMutableURLRequest *)createTaskRequestWithUserId:(NSString *) userId projectId:(NSString *)projectId;
- (NSMutableURLRequest *)updateTaskRequestWithTask:(EXCTask *) task;
- (NSMutableURLRequest *)deleteTaskRequestwithTaskId:(NSString *) taskId;

@end
