//
//  APIManager.h
//  httpSpike
//
//  Created by u16suzu on 2014/07/12.
//  Copyright (c) 2014年 u16suzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedInstance;
- (void)fetchNews:(void (^)(NSArray *news, NSError *error))handler;
@end
