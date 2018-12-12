//
//  EXCReview.h
//  Executor
//
//  Created by Suguru on 11/19/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCReview : NSObject

@property (nonatomic) long reviewId;
@property (nonatomic) NSString *reviewTitle;
@property (nonatomic) NSString *reviewDescription;
@property (nonatomic) NSDate *postDate;

- (instancetype)initWithReviewId:(long)reviewId reviewTitle:(NSString *)reviewTitle reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate;
- (instancetype)initWithReviewTitle:(NSString *)reviewTitle reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate;

@end
