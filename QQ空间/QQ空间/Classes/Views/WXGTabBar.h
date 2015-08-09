//
//  WXGTabBar.h
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//  侧边Dock的中间标签栏

#import <UIKit/UIKit.h>

@class WXGTabBar;

/**
 *  代理协议
 */
@protocol WXGTabbarDelegate <NSObject>

@optional
- (void)tabbar:(WXGTabBar *)tabbar fromIndex:(NSInteger)from toIndex:(NSInteger)to;

@end


@interface WXGTabBar : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id<WXGTabbarDelegate> delegate;

/**
 *  告知当前屏幕是否为横屏
 */
- (void)rotateToLandscape:(BOOL)isLandscape;

/**
 *  取消标签选中
 */
- (void)unSelected;

/**
 *  默认选中第一个
 */
- (void)selectedFirst;

@end


/**
 *  标签中的自定义按钮
 */
@interface WXGTabBarItem : UIButton

@end
