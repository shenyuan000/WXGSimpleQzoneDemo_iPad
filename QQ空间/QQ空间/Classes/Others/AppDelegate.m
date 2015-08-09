//
//  AppDelegate.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 更改状态栏样式，Info.plist文件中需配置
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

@end
