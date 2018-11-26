//
//  ProjectService.h
//  Executor
//
//  Created by Suguru on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfoService.h"
#import "EXCMutableURLRequest.h"
#import "EXCProject.h"

@interface ProjectService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getProjectsRequestWithUserId:(NSString *)userId;
- (NSMutableURLRequest *)getProjectsRequestWithProjectId:(NSString *)projectId;
- (NSMutableURLRequest *)createProjectRequestWithUserId:(NSString *)userId project:(EXCProject *)project;
- (NSMutableURLRequest *)deleteProjectRequestWithProjectId:(NSString *)projectId;
- (NSMutableURLRequest *)updateProjectRequestWithProject:(EXCProject *)project;

- (EXCProject *)getProjectWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getProjectsWithJsonData:(NSData *)jsonData error:(NSError *)err;

@end
