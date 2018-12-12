//
//  EXCReviewService.h
//  Executor
//
//  Created by Suguru on 12/6/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXCReview.h"
#import "EXCSessionInfoService.h"

@interface EXCReviewService : NSObject

@property (nonatomic) NSString *endPoint;

- (NSMutableURLRequest *)getReviewsRequestWithUserId:(long)userId projectId:(long)projectId reviewerId:(long) reviewerId;
- (NSMutableURLRequest *)getReviewRequestWithReviewId:(long)reviewId;
- (NSMutableURLRequest *)createReviewRequestWithReview:(EXCReview *)review;
- (NSMutableURLRequest *)updateReviewRequestWithReview:(EXCReview *)review;
- (NSMutableURLRequest *)deleteReviewRequestWithReviewId:(long)reviewId;
- (NSData *)getReviewPostDataWithReview:(EXCReview *)review;
- (EXCReview *)getReviewWithJsonData:(NSData *)jsonData error:(NSError *)err;
- (NSMutableArray *)getReviewsWithJsonData:(NSData *)jsonData error:(NSError *)err;
+ (EXCReview *)getReviewWithReviewDictionary:(NSDictionary *)reviewDictionary;

@end
