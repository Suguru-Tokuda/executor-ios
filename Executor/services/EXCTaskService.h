//
//  TaskService.h
//  Executor
//
//  Created by Suguru on 11/25/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCTask.h"
#import "EXCSessionInfoService.h"

@interface EXCTaskService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getTasksRequestWithProjectId:(long)projectId userId:(long)userId;
- (NSMutableURLRequest *)getTaskRequestWithTaskId:(long)taskId;
- (NSMutableURLRequest *)createTaskRequestWithTask:(EXCTask *)task;
- (NSMutableURLRequest *)updateTaskRequestWithTask:(EXCTask *)task;
- (NSMutableURLRequest *)deleteTaskRequestwithTaskId:(long) taskId;
- (NSData *)getPostDataWithTask:(EXCTask *)task;
- (EXCTask *)getTaskWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getTasksWithJsonData:(NSData *)jsonData error:(NSError *)err;
+ (EXCTask *)getTaskWithDictionary:(NSDictionary *)dictioinary;

@end
