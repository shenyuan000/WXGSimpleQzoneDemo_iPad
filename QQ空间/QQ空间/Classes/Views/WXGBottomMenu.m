//
//  WXGBottomMenu.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGBottomMenu.h"

@implementation WXGBottomMenu

#pragma mark - 初始化设置

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化子控件
        [self setupItemWithImageName:@"tabbar_mood" type:WXGBottomMenuItemTypeMood];
        [self setupItemWithImageName:@"tabbar_photo" type:WXGBottomMenuItemTypePhoto];
        [self setupItemWithImageName:@"tabbar_blog" type:WXGBottomMenuItemTypeBlog];
    }
    return self;
}

- (void)setupItemWithImageName:(NSString *)imageName type:(WXGBottomMenuItemType)type {
    UIButton *item = [[UIButton alloc] init];
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    item.tag = type; // 绑定tag作为类型
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
}

#pragma mark - 监听按钮点击

- (void)itemClick:(UIButton *)item {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomMenu:type:)]) {
        [self.delegate bottomMenu:self type:item.tag];
    }
}

#pragma mark - 被告知当前屏幕是否为横屏

- (void)rotateToLandscape:(BOOL)isLandscape {
    // 0. 获取子控件个数
    NSUInteger count = self.subviews.count;
    
    // 1. 设置自身的frame
    self.width = self.superview.width;
    self.height = isLandscape ? kDockItemHeight : kDockItemHeight * count;
    self.y = self.superview.height - self.height;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    // 2. 设置子控件的frame
    for (int i = 0; i < count; i++) {
        UIButton *item = self.subviews[i];
        item.width = isLandscape ? self.width / count : self.width;
        item.height = kDockItemHeight;
        item.x = isLandscape ? item.width * i : 0;
        item.y = isLandscape ? 0 : item.height * i;
    }
}

@end
