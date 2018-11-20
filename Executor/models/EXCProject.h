//
//  EXCProject.h
//  Executor
//
//  Created by Suguru on 11/18/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCProject: NSObject

@property (nonatomic) NSString *projectId;
@property (nonatomic) NSString *projectName;
@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSData *picture;
@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) Boolean completed;
@property (nonatomic) Boolean archived;

- (instancetype)initWithName:(NSString *)projectName;
- (instancetype)initWithId:(NSString *)projectId projectName:(NSString *)projectName startDate:(NSDate *)startDate endDate:(NSDate *)endDate picture:(NSData *)picture tasks:(NSMutableArray *)tasks completed:(Boolean)completed archived:(Boolean)archived;

@end
