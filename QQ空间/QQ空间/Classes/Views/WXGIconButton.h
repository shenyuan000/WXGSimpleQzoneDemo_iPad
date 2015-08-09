//
//  WXGIconButton.h
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//  侧边Dock的顶部头像

#import <UIKit/UIKit.h>

@interface WXGIconButton : UIButton

/**
 *  告知当前屏幕是否为横屏
 */
- (void)rotateToLandscape:(BOOL)isLandscape;

@end
