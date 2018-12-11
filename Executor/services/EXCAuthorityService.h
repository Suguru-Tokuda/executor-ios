//
//  EXCAuthorityService.h
//  Executor
//
//  Created by Suguru on 12/10/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCAuthority.h"
#import "EXCSessionInfoService.h"

@interface EXCAuthorityService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)createAuthorityRequestWithAuthority:(EXCAuthority *)authority projectId:(long)projectId;
- (NSMutableURLRequest *)updateAuthorityRequestWithAuthority:(EXCAuthority *)authority;
- (NSMutableURLRequest *)deleteAuthorityRequestWithAuthorityId:(long)authorityId;
- (NSData *)getAuthorityPostDataWithAuthority:(EXCAuthority *)authority;
- (EXCAuthority *)getAuthorityWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getAuthoritiesWithJsonData:(NSData *)jsonData error:(NSError *)err;
+ (EXCAuthority *)getAuthorityWithAuthorityDictionary:(NSDictionary *)authorityDictionary;

@end
