//
//  WXGIconButton.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGIconButton.h"

@implementation WXGIconButton

/**
 *  初始化设置
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"我是乔" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

/**
 *  被告知当前屏幕是否为横屏
 */
- (void)rotateToLandscape:(BOOL)isLandscape {
    // 设置自身的frame
    self.width = isLandscape ? kIconButtonLandscapeWidth : kIconButtonPortraitWH;
    self.height = isLandscape ? kIconButtonLandscapeHeight : kIconButtonPortraitWH;
    self.x = (self.superview.width - self.width) * 0.5;
    self.y = kIconButtonY;
}

/**
 *  返回图片的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if (self.width == self.height) { // 竖屏
        return contentRect;
    } else { // 横屏
        contentRect.size.height = contentRect.size.width;
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
        contentRect.origin.y = contentRect.size.width;
        contentRect.size.height = kIconButtonLandscapeTitleH;
        return contentRect;
    }
}

@end
