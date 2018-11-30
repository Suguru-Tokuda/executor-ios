//
//  TaskService.h
//  Executor
//
//  Created by Suguru on 11/25/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCTask.h"
#import "AccountInfoService.h"

@interface TaskService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getTasksRequestWithProjectId:(NSString *)projectId userId:(NSString *)userId;
- (NSMutableURLRequest *)getTaskRequestWithTaskId:(NSString *)taskId;
- (NSMutableURLRequest *)createTaskRequestWithTask:(EXCTask *)task;
- (NSMutableURLRequest *)updateTaskRequestWithTask:(EXCTask *)task;
- (NSMutableURLRequest *)deleteTaskRequestwithTaskId:(NSString *) taskId;

- (NSData *)getPostDataWithTask:(EXCTask *)task;

@end
