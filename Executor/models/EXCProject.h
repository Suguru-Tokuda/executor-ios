//
//  EXCProject.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCProject: NSObject

@property (nonatomic) long projectId;
@property (nonatomic) NSString *projectName;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSData *picture;
@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) Boolean completed;

- (instancetype)initWithName:(NSString *)projectName;
- (instancetype)initWithTaskId:(long)projectId projectName:(NSString *)projectName startDate:(NSDate *)startDate endDate:(NSDate *)endDate picture:(NSData *)picture tasks:(NSMutableArray *)tasks completed:(Boolean)completed;

@end
