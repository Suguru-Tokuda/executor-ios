//
//  Review.m
//  Executor
//
//  Created by Suguru on 11/19/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype) initWithReviewId:(NSString *)reviewId
                            title:(NSString *)title
                reviewDescription:(NSString *)reviewDescription
                         postDate:(NSDate *)postDate {
    self = [super init];
    self.reviewId = reviewId;
    self.title = title;
    self.reviewDescription = reviewDescription;
    self.postDate = postDate;
    return self;
}

- (instancetype) initWithTitle:(NSString *)title
             reviewDescription:(NSString *)reviewDescription
                      postDate:(NSDate *)postDate {
    self = [super init];
    self.title = title;
    self.reviewDescription = reviewDescription;
    self.postDate = postDate;
    return self;
}

@end