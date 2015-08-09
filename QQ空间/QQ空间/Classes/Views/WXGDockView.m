//
//  WXGDockView.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDockView.h"
#import "WXGBottomMenu.h"
#import "WXGTabBar.h"
#import "WXGIconButton.h"

@interface WXGDockView ()

@end

@implementation WXGDockView

#pragma mark - 初始化设置

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1. 设置底部菜单
        [self setupBottomMenu];
        
        // 2. 设置中间标签
        [self setupTabBar];
        
        // 3. 设置顶部头像
        [self setupIconButton];
    }
    return self;
}

- (void)setupIconButton {
    WXGIconButton *iconButton = [[WXGIconButton alloc] init];
    [self addSubview:iconButton];
    _iconButton = iconButton;
}

- (void)setupTabBar {
    WXGTabBar *tabBar = [[WXGTabBar alloc] init];
    [self addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)setupBottomMenu {
    WXGBottomMenu *bottomMenu = [[WXGBottomMenu alloc] init];
    [self addSubview:bottomMenu];
    _bottomMenu = bottomMenu;
}

#pragma mark - 告知当前屏幕是否为横屏

- (void)rotateToLandscape:(BOOL)isLandscape {
    // 1. 设置Dock自身的frame
    self.width = isLandscape ? kDockLandscapeWidth : kDockPortraitWidth;
    self.height = self.superview.height;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    // 2. 告知底部菜单当前屏幕是否为横屏
    [self.bottomMenu rotateToLandscape:isLandscape];
    
    // 3. 告知中间标签当前屏幕是否为横屏
    [self.tabBar rotateToLandscape:isLandscape];
    self.tabBar.y = self.superview.height - self.bottomMenu.height - self.tabBar.height;
    
    // 4. 告知顶部头像当前屏幕是否为横屏
    [self.iconButton rotateToLandscape:isLandscape];
}

@end
