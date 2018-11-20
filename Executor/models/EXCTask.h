//
//  EXCTask.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCTask : NSObject

@property (nonatomic) NSString *taskId;
@property (nonatomic) NSString *taskName;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) Boolean completed;
@property (nonatomic) Boolean approved;

- (instancetype) initWithName:(NSString *)taskName;
- (instancetype) initWithId:(NSString *)taskId
                   taskName: (NSString *)taskName
                  startDate: (NSDate *)startDate
                    endDate: (NSDate *)endDate
                  completed: (Boolean)completed
                   approved: (Boolean)approved;

@end
