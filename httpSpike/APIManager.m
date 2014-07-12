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
#define API_BASE @"http://staging.api.example.com/" // ここをかえる
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

// 共通処理､共通設定をココでかく
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(void (^)(NSURLResponse *, id, NSError *))completionHandler
{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    mutableRequest.timeoutInterval = 20.0;
    
    return [super dataTaskWithRequest:mutableRequest completionHandler:completionHandler];
}

#pragma mark - API methods

// ココでAPIごとに実装
- (void)fetchNews:(void (^)(NSArray *, NSError *))handler{
    [self GET:@"v1/entries/recent.json" parameters:@{@"page" : @1}
      success:^(NSURLSessionDataTask *task, id responseObject) {
          
        NSArray *news = [News newsWithResponse:responseObject];
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

