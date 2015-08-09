//
//  WXGTabBar.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGTabBar.h"

@interface WXGTabBar ()

/**
 *  记录选中的按钮
 */
@property (nonatomic, weak) WXGTabBarItem *selectedItem;

@end

@implementation WXGTabBar

#pragma mark - 初始化设置

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化子控件
        [self setupItemWithImageName:@"tab_bar_feed_icon" title:@"全部动态"];
        [self setupItemWithImageName:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupItemWithImageName:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupItemWithImageName:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupItemWithImageName:@"tab_bar_friend_icon" title:@"好友"];
        [self setupItemWithImageName:@"tab_bar_e_more_icon" title:@"更多"];
    }
    return self;
}

- (void)setupItemWithImageName:(NSString *)imageName title:(NSString *)title {
    WXGTabBarItem *item = [[WXGTabBarItem alloc] init];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    item.tag = self.subviews.count; // 绑定tag作为索引
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:item];
}

#pragma mark - 监听按钮点击

- (void)itemClick:(WXGTabBarItem *)item {
    // 1. 通知代理
    if ([self.delegate respondsToSelector:@selector(tabbar:fromIndex:toIndex:)]) {
        [self.delegate tabbar:self fromIndex:self.selectedItem.tag toIndex:item.tag];
    }
    
    // 2. 记录选中按钮
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
}

#pragma mark - 被告知当前屏幕是否为横屏

- (void)rotateToLandscape:(BOOL)isLandscape {
    // 0. 获取子控件个数
    NSUInteger count = self.subviews.count;
    
    // 1. 设置自身的frame
    self.width = self.superview.width;
    self.height = kDockItemHeight * 6;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    // 2. 设置子控件的frame
    for (int i = 0; i < count; i++) {
        UIButton *item = self.subviews[i];
        item.width = self.width;
        item.height = kDockItemHeight;
        item.y = item.height * i;
    }
}

#pragma mark - 对外提供的方法

- (void)unSelected {
    self.selectedItem.selected = NO;
}

- (void)selectedFirst {
    [self itemClick:self.subviews[0]];
}

@end


/**
 *  横屏时图片在按钮中所占比例
 */
static const CGFloat kRatio = 0.4;


@implementation WXGTabBarItem

/**
 *  初始化设置
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

/**
 *  取消高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {
    // Noting to do.
}

/**
 *  返回图片的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (self.width == self.height) { // 竖屏
        return contentRect;
    } else { // 横屏
        contentRect.size.width = contentRect.size.width * kRatio;
        return contentRect;
    }
}

/**
 *  返回标题的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (self.width == self.height) { // 竖屏
        // 文字露出小bug
//        return CGRectZero;
        return CGRectMake(0, 0, -1, -1);
    } else { // 横屏
        contentRect.origin.x = contentRect.size.width * kRatio;
        contentRect.size.width = contentRect.size.width * (1 - kRatio);
        return contentRect;
    }
}

@end
