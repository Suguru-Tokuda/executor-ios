//
//  EXCReview.m
//  Executor
//
//  Created by Suguru on 11/19/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "EXCReview.h"

@implementation EXCReview

- (instancetype)initWithReviewId:(long)reviewId reviewTitle:(NSString *)title reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate {
    self = [super init];
    self.reviewId = reviewId;
    self.reviewTitle = title;
    self.reviewDescription = reviewDescription;
    self.postDate = postDate;
    return self;
}

- (instancetype)initWithReviewTitle:(NSString *)title reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate {
    self = [super init];
    self.reviewTitle = title;
    self.reviewDescription = reviewDescription;
    self.postDate = postDate;
    return self;
}

@end
