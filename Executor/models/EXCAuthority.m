//
//  EXCAuthority.m
//  Executor
//
//  Created by Suguru on 12/5/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCAuthority.h"

@implementation EXCAuthority

- (instancetype)initWithAuthorityName:(NSString *)authorityName privileges:(NSMutableArray *)privileges projectId:(long)projectId {
    self = [super init];
    self.authorityName = authorityName;
    self.privileges = privileges;
    self.projectId = projectId;
    return self;
}

- (instancetype)initWithAuthorityId:(long)authorityId authorityName:(NSString *)authorityName privileges:(NSMutableArray *)privileges projectId:(long)projectId {
    self = [super init];
    self.authorityId = authorityId;
    self.authorityName = authorityName;
    self.privileges = privileges;
    self.projectId = projectId;
    return self;
}

@end
