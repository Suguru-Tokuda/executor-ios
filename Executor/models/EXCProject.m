//
//  Project.m
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCProject.h"

@implementation EXCProject

- (instancetype) initWithName:(NSString *)projectName {
    self = [super init];
    self.projectName = projectName;
    return self;
}

- (instancetype) initWithId:(NSString *)projectId
                projectName:(NSString *)projectName
                  startDate:(NSDate *)startDate
                    endDate:(NSDate *)endDate
                    picture:(NSData *)picture
                      tasks:(NSMutableArray *)tasks
                  completed:(Boolean)completed
                   archived:(Boolean)archived {
    self = [super init];
    self.projectId = projectId;
    self.projectName = projectName;
    self.startDate = startDate;
    self.endDate = endDate;
    self.picture = picture;
    self.tasks = tasks;
    self.completed = completed;
    self.archived = archived;
    return self;
}

@end
