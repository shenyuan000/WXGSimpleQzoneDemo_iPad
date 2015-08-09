//
//  WXGDockView.h
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//  主页边栏Dock

#import <UIKit/UIKit.h>

@class WXGBottomMenu, WXGTabBar, WXGIconButton;

@interface WXGDockView : UIView

/**
 *  底部菜单
 */
@property (nonatomic, weak, readonly) WXGBottomMenu *bottomMenu;
/**
 *  中间标签
 */
@property (nonatomic, weak, readonly) WXGTabBar *tabBar;
/**
 *  顶部头像
 */
@property (nonatomic, weak, readonly) WXGIconButton *iconButton;

/**
 *  告知当前屏幕是否为横屏
 */
- (void)rotateToLandscape:(BOOL)isLandscape;

@end
