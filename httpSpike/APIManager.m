//
//  APIManager.m
//  httpSpike
//
//  Created by u16suzu on 2014/07/12.
//  Copyright (c) 2014年 u16suzu. All rights reserved.
//

#import "APIManager.h"
#import "News.h"

#ifdef DEBUG
#define API_BASE @"http://staging.api.example.com/"
#else
#define API_BASE @"http://api.example.com/"
#endif

@implementation APIManager

+ (instancetype)sharedInstance{
    static APIManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[APIManager alloc] init];
    });
    
    return _shared;
}

- (instancetype)init{
    if (self = [super initWithBaseURL:[NSURL URLWithString:API_BASE]]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        return self;
    } else {
        return nil;
    }
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    mutableRequest.timeoutInterval = 20.0; // なんか共通でやっときたいこと色々
    return [super dataTaskWithRequest:mutableRequest completionHandler:completionHandler];
}

- (void)fetchNews:(void (^)(NSArray *, NSError *))handler{
    [self GET:@"/api/v1/news" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *news; // = [News newsWithResponse:responseObject]; // News クラスのオブジェクトの配列を返すとして。
        
        if (handler) {
            handler(news, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (handler) {
            handler(nil, error);
        }
    }];
}

@end


