//
//  EXCReviewService.m
//  Executor
//
//  Created by Suguru on 12/6/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCReviewService.h"

@implementation EXCReviewService

- (instancetype)init{
    self = [super init];
    self.endPoint = [NSString stringWithFormat:@"%@%@", BASE_URL, @"/reviews"];
    return self;
}

// MARK: Request methods
- (NSMutableURLRequest *)getReviewsRequestWithUserId:(long)userId projectId:(long)projectId reviewerId:(long) reviewerId {
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@%@",
                               _endPoint,
                               (userId == 0 ? @"" : [NSString stringWithFormat:@"/%ld", userId]),
                               (projectId == 0 ? @"" : [NSString stringWithFormat:@"/%ld", projectId]),
                               (reviewerId == 0 ? @"" : [NSString stringWithFormat:@"/%ld", reviewerId])];
    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    return req;
}

- (NSMutableURLRequest *)getReviewRequestWithReviewId:(long)reviewId {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%ld", _endPoint, reviewId]];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"GET"];
    return req;
}

- (NSMutableURLRequest *)createReviewRequestWithReview:(EXCReview *)review {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    NSData *postData = [self getReviewPostDataWithReview:review];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)updateReviewRequestWithReview:(EXCReview *)review {
    NSURL *url = [NSURL URLWithString:_endPoint];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"PATCH"];
    NSData *postData = [self getReviewPostDataWithReview:review];
    [req setHTTPBody:postData];
    return req;
}

- (NSMutableURLRequest *)deleteReviewRequestWithReviewId:(long)reviewId {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%ld", _endPoint, reviewId]];
    NSMutableURLRequest *req = [EXCMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"DELETE"];
    return req;
}

// MARK: Post data method
- (NSData *)getReviewPostDataWithReview:(EXCReview *)review {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDictionary *jsonBodyDictionary = @{@"title":review.title, @"reviewDescription":review.reviewDescription, @"postDate":[dateFormatter stringFromDate:review.postDate]};;
    if (review.reviewId != 0) {
        [jsonBodyDictionary setValue:[NSString stringWithFormat:@"%ld", review.reviewId] forKey:@"reviewId"];
    }
    NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonBodyDictionary options:kNilOptions error:nil];
    return postData;
}

@end
