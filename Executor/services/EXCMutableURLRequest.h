//
//  EXCMutableURLRequest.h
//  Executor
//
//  Created by Suguru Tokuda on 11/21/18.
//  Copyright © 2018 Executor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface EXCMutableURLRequest : NSObject

+ (NSMutableURLRequest *)requestWithURL:(NSURL *) url;

@end
