//
//  EXCTask.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCTask.h"

@implementation EXCTask

- (instancetype)initWithName:(NSString *)taskName {
    self = [super init];
    self.taskName = taskName;
    return self;
}

- (instancetype)initWithTaskId:(long)taskId taskName:(NSString *)taskName startDate:(NSDate *)startDate endDate:(NSDate *)endDate completed:(Boolean)completed approved:(Boolean)approved {
    self = [super init];
    self.taskId = taskId;
    self.taskName = taskName;
    self.startDate = startDate;
    self.endDate = endDate;
    self.completed = completed;
    self.approved = approved;
    return self;
}

- (instancetype)initWithTaskId:(long)taskId taskName:(NSString *)taskName startDate:(NSDate *)startDate endDate:(NSDate *)endDate completed:(Boolean)completed approved:(Boolean)approved projectId:(long)projectId userId:(long)userId {
    self = [super init];
    self.taskId = taskId;
    self.taskName = taskName;
    self.startDate = startDate;
    self.endDate = endDate;
    self.completed = completed;
    self.approved = approved;
    self.projectId = projectId;
    self.userId = userId;
    return self;
}

@end
