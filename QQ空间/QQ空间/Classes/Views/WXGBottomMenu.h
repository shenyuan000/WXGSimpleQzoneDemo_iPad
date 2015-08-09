//
//  WXGBottomMenu.h
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//  侧边Dock的底部菜单

#import <UIKit/UIKit.h>

/**
 *  底部菜单按钮类型
 */
typedef NS_ENUM(NSInteger, WXGBottomMenuItemType){
    /**
     *  发表心情
     */
    WXGBottomMenuItemTypeMood,
    /**
     *  发表照片
     */
    WXGBottomMenuItemTypePhoto,
    /**
     *  发表日志
     */
    WXGBottomMenuItemTypeBlog
};


@class WXGBottomMenu;

/**
 *  代理协议
 */
@protocol WXGBottomMenuDelegate <NSObject>

@optional
- (void)bottomMenu:(WXGBottomMenu *)bottomMenu type:(WXGBottomMenuItemType)type;

@end


@interface WXGBottomMenu : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id<WXGBottomMenuDelegate> delegate;

/**
 *  告知当前屏幕是否为横屏
 */
- (void)rotateToLandscape:(BOOL)isLandscape;

@end
