//
//  EXCReview.h
//  Executor
//
//  Created by Suguru on 11/19/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXCReview : NSObject

@property (nonatomic) NSString *reviewId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *reviewDescription;
@property (nonatomic) NSDate *postDate;

- (instancetype)initWithReviewId:(NSString *)reviewId title:(NSString *)title reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate;
- (instancetype)initWithTitle:(NSString *)title reviewDescription:(NSString *)reviewDescription postDate:(NSDate *)postDate;

@end
