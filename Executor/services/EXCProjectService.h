//
//  ProjectService.h
//  Executor
//
//  Created by Suguru on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCAccountInfoService.h"
#import "EXCMutableURLRequest.h"
#import "EXCProject.h"

@interface EXCProjectService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getProjectsRequestWithUserId:(long)userId;
- (NSMutableURLRequest *)getProjectsRequestWithProjectId:(long)projectId;
- (NSMutableURLRequest *)createProjectRequestWithUserId:(long)userId project:(EXCProject *)project;
- (NSMutableURLRequest *)deleteProjectRequestWithProjectId:(long)projectId;
- (NSMutableURLRequest *)updateProjectRequestWithProject:(EXCProject *)project;
- (EXCProject *)getProjectWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getProjectsWithJsonData:(NSData *)jsonData error:(NSError *)err;
+ (EXCProject *)getProjectWithDictionary:(NSDictionary *)dictionary;
- (NSData *)getPostDataWithProject:(EXCProject *)project;

@end
