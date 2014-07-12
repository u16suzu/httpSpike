//
//  News.m
//  httpSpike
//
//  Created by u16suzu on 2014/07/12.
//  Copyright (c) 2014年 u16suzu. All rights reserved.
//

#import "News.h"

@interface News()
@property (nonatomic) NSString*title;
@property (nonatomic) NSString*url;
@end

@implementation News

- (instancetype)initWithDict:(id)dict{
    self = [super init];
    if(self){
        _title = dict[@"title"];
        _url   = dict[@"url"];
    }
    return self;
}

+ (NSArray*)newsWithResponse:(id)responseObject{
    NSArray*ar = (NSArray*)responseObject;
    NSMutableArray*res = @[].mutableCopy;
    [ar enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [res addObject:[[News alloc] initWithDict:obj]];
    }];
    
    return [res copy];
}

- (NSString*)description{
    return [NSString stringWithFormat:@"title : %@ url : %@", self.title, self.url];
}

@end
