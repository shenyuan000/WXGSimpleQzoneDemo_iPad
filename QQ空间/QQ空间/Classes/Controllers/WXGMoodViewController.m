//
//  WXGMoodViewController.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMoodViewController.h"

@interface WXGMoodViewController ()

@end

@implementation WXGMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置背景色
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 2. 设置导航栏
    self.navigationItem.title = @"发表心情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
}

/**
 *  点击关闭
 */
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击发表
 */
- (void)post {
    NSLog(@"发表心情");
}

@end
