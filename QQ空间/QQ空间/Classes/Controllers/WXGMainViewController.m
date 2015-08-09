//
//  WXGMainViewController.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMainViewController.h"
#import "WXGDockView.h"
#import "WXGBottomMenu.h"
#import "WXGTabBar.h"
#import "WXGIconButton.h"
#import "WXGMoodViewController.h"

@interface WXGMainViewController () <WXGBottomMenuDelegate, WXGTabbarDelegate>

/**
 *  Dock边栏
 */
@property (nonatomic, weak) WXGDockView *dock;
/**
 *  主页内容控件
 */
@property (nonatomic, weak) UIView *contentView;
/**
 *  记录主页内容当前展示视图所在控制器的索引
 */
@property (nonatomic, assign) NSInteger index;

@end

@implementation WXGMainViewController

#pragma mark - 初始化设置

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0. 设置背景颜色
    self.view.backgroundColor = WXGRGBColor(55, 55, 55);
    
    // 1. 设置Dock边栏
    [self setupDock];
    
    // 2. 设置主内容控件
    [self setupContentView];
    
    // 3. 设置子控制器
    [self setupChildViewControllers];
    
    // 4. 默认展示全部动态界面
    [self.dock.tabBar selectedFirst];
}

/**
 *  设置所有子控制器
 */
- (void)setupChildViewControllers {
    [self setupChildViewController:[[UIViewController alloc] init] title:@"全部动态"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"与我相关"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"照片墙"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"电子相框"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"好友"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"更多"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"个人中心"];
}

/**
 *  设置单个子控制器
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationItem.title = title;
    vc.view.backgroundColor = WXGRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));;
    [self addChildViewController:nav];
}

/**
 *  设置主内容控件
 */
- (void)setupContentView {
    UIView *contentView = [[UIView alloc] init];
    contentView.width = kContentViewWidth;
    contentView.height = self.view.height - kStatusBarHeight;
    contentView.x = self.dock.width;
    contentView.y = kStatusBarHeight;
    // 禁止默认的宽度自适应
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

/**
 *  设置Dock边栏
 */
- (void)setupDock {
    // 1. 添加Dock
    WXGDockView *dock = [[WXGDockView alloc] init];
    [self.view addSubview:dock];
    self.dock = dock;
    
    // 2. 告知Dock当前屏幕方向
    BOOL isLandscape = (self.view.width > self.view.height);
    [dock rotateToLandscape:isLandscape];
    
    // 3. 设置底部菜单的代理
    self.dock.bottomMenu.delegate = self;
    
    // 4. 设置中间标签的代理
    self.dock.tabBar.delegate = self;
    
    // 5. 监听顶部头像的点击
    [self.dock.iconButton addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - 监听屏幕的旋转

/**
 *  当屏幕发生旋转时会调用
 *
 *  @param size        变动后的size
 *  @param coordinator 可获取动画执行时间
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    // 1. 判断当前屏幕方向
    BOOL isLandscape = (size.width > size.height);
    
    // 2. 获取动画执行时间
    CGFloat duration = [coordinator transitionDuration];
    
    // 3. 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 告知Dock当前屏幕方向
        [self.dock rotateToLandscape:isLandscape];
        
        // 更新主内容控件的x值
        self.contentView.x = self.dock.width;
    }];
}

#pragma mark - 底部菜单的代理方法

- (void)bottomMenu:(WXGBottomMenu *)bottomMenu type:(WXGBottomMenuItemType)type {
    switch (type) {
        case WXGBottomMenuItemTypeMood: // 发表心情
        {
            WXGMoodViewController *moodVc = [[WXGMoodViewController alloc] init];
            UINavigationController *moodNav = [[UINavigationController alloc] initWithRootViewController:moodVc];
            
            // 设置modal展示样式
            moodNav.modalPresentationStyle = UIModalPresentationFormSheet;
            
            [self presentViewController:moodNav animated:YES completion:nil];
        }
            break;
        case WXGBottomMenuItemTypePhoto: // 发表照片
            NSLog(@"发表照片");
            break;
        case WXGBottomMenuItemTypeBlog: // 发表博客
            NSLog(@"发表博客");
            break;
        default:
            break;
    }
}

#pragma mark - 中间标签的代理方法

- (void)tabbar:(WXGTabBar *)tabbar fromIndex:(NSInteger)from toIndex:(NSInteger)to {
    // 1. 移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 2. 添加新控制器的view
    UIViewController *newVc = self.childViewControllers[to];
    newVc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:newVc.view];
    
    // 3. 记录当前控制器索引
    self.index = to;
}

#pragma mark - 监听顶部头像的点击

- (void)iconBtnClick {
    // 1. 展示个人中心界面
    [self tabbar:nil fromIndex:self.index toIndex:self.childViewControllers.count - 1];
    
    // 2. 取消标签栏的选中
    [self.dock.tabBar unSelected];
}

@end
