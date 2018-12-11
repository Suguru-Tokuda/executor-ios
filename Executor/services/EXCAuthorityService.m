//
//  EXCAuthorityService.m
//  Executor
//
//  Created by Suguru on 12/10/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCAuthorityService.h"

@implementation EXCAuthorityService

- (instancetype)init {
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/authorities"];
    return self;
}

// MARK: Request methods
- (NSMutableURLRequest *)createAuthorityRequestWithAuthority:(EXCAuthority *)authority projectId:(long)projectId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", _endPoint, projectId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    NSData *postData = [self getAuthorityPostDataWithAuthority:authority];
    [req setHTTPBody:postData];
    [req setHTTPMethod:@"POST"];
    return req;
}

- (NSMutableURLRequest *)updateAuthorityRequestWithAuthority:(EXCAuthority *)authority {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    NSData *postData = [self getAuthorityPostDataWithAuthority:authority];
    [req setHTTPBody:postData];
    [req setHTTPMethod:@"PATCH"];
    return req;
}

- (NSMutableURLRequest *)deleteAuthorityRequestWithAuthorityId:(long)authorityId {
    NSString *requestString = [NSString stringWithFormat:@"%@/%ld", _endPoint, authorityId];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}

// MARK: Post data method
- (NSData *)getAuthorityPostDataWithAuthority:(EXCAuthority *)authority {
    NSString *privilegStr = @"";
    if (sizeof(authority.privileges) > 0) {
        for (NSString *privilege in authority.privileges) {
            privilegStr = [NSString stringWithFormat:@"%@%@", privilegStr, privilege];
        }
    }
    NSDictionary *authorityBodyDictionary = @{
                                          @"authorityName":authority.authorityName,
                                          @"privilegeStr":privilegStr,
                                          };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:authorityBodyDictionary options:kNilOptions error:nil];
    return postData;
}

// MARK: JSON parser methods
- (EXCAuthority *)getAuthorityWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSDictionary *authorityDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON:%@", err);
    EXCAuthority *authority = [EXCAuthorityService getAuthorityWithAuthorityDictionary:authorityDictionary];
    return authority;
}

- (NSMutableArray *)getAuthoritiesWithJsonData:(NSData *)jsonData error:(NSError *)err {
    NSArray *authorityDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    if (err)
        NSLog(@"failed to serialize into JSON:%@", err);
    NSMutableArray *authorities = [[NSMutableArray alloc] init];
    for (NSDictionary *authorityJson in authorityDictionary) {
        EXCAuthority *authority = [EXCAuthorityService getAuthorityWithAuthorityDictionary:authorityJson];
        [authorities addObject:authority];
    }
    return authorities;
}

+ (EXCAuthority *)getAuthorityWithAuthorityDictionary:(NSDictionary *)authorityDictionary {
    NSMutableArray *privileges = [[NSMutableArray alloc] init];
    if (![authorityDictionary[@"privilegeStr"] isEqualToString:@""]) {
        for (NSString *privilege in [authorityDictionary[@"privilegeStr"] componentsSeparatedByString:@";"])
            [privileges addObject:privilege];
    }
    EXCAuthority *authority = [[EXCAuthority alloc] initWithAuthorityId:[authorityDictionary[@"authorityId"] longValue]
                                                        authorityName:authorityDictionary[@"authorityName"]
                                                           privileges:privileges
                                                            projectId:[authorityDictionary[@"project"][@"projectId"] longValue]];
    return authority;
}

@end
