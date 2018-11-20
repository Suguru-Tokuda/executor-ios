//
//  Task.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCTask.h"

@implementation EXCTask

- (instancetype) initWithName:(NSString *)taskName {
    self = [super init];
    self.taskName = taskName;
    return self;
}

- (instancetype) initWithId:(NSString *)taskId taskName:(NSString *)taskName startDate:(NSDate *)startDate endDate:(NSDate *)endDate completed:(Boolean)completed approved:(Boolean)approved {
    self = [super init];
    self.taskId = taskId;
    self.taskName = taskName;
    self.startDate = startDate;
    self.endDate = endDate;
    self.completed = completed;
    self.approved = approved;
    return self;
}

@end
