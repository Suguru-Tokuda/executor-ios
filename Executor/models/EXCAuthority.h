//
//  EXCAuthority.h
//  Executor
//
//  Created by Suguru on 12/5/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCAuthority : NSObject

@property (nonatomic) long authorityId;
@property (nonatomic) NSString *authorityName;
@property (nonatomic) NSMutableArray *privileges;
@property (nonatomic) long projectId;

- (instancetype)initWithAuthorityName:(NSString *)authorityName privileges:(NSMutableArray *)privileges projectId:(long)projectId;
- (instancetype)initWithAuthorityId:(long)authorityId authorityName:(NSString *)authorityName privileges:(NSMutableArray *)privileges projectId:(long)projectId;

@end

