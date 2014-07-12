//
//  ViewController.m
//  httpSpike
//
//  Created by u16suzu on 2014/07/12.
//  Copyright (c) 2014年 u16suzu. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()
@property (nonatomic) UITableView*table;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[APIManager sharedInstance] fetchNews:^(NSArray *news, NSError *error) {
        NSLog(@"%@", news) ;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
