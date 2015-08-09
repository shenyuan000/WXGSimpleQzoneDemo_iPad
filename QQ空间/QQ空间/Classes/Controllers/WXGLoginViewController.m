//
//  WXGLoginViewController.m
//  QQ空间
//
//  Created by Nicholas Chow on 15/8/9.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGLoginViewController.h"
#import "WXGMainViewController.h"

@interface WXGLoginViewController () <UITextFieldDelegate>

/**
 *  帐号文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *accountField;
/**
 *  密码文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
/**
 *  记住密码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *remPwdBtn;
/**
 *  自动登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;
/**
 *  整个登录控件
 */
@property (weak, nonatomic) IBOutlet UIView *loginView;
/**
 *  登录指示器
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivity;

@end

@implementation WXGLoginViewController

#pragma mark - 登录相关

/**
 *  点击登录按钮
 */
- (IBAction)login {
    // 0. 退出键盘
    [self.view endEditing:YES];
    
    // 1. 获取帐号和密码
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    
    // 2. 判断帐号密码是否为空
    if (account.length == 0 || password.length == 0) {
        // 登录失败，提示用户失败信息
        [self showError:@"用户名和密码不能为空!!"];
        return;
    }
    
    // 3. 通过请求服务器来判断帐号密码是否正确
    CGFloat duration = 1.0; // 模拟请求时间
    
    // 请求期间禁止用户交互
    self.view.userInteractionEnabled = NO;
    // 启动登录指示器
    [self.loginActivity startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([account isEqualToString:@"123"] && [password isEqualToString:@"123"]) {
            // 登录成功，跳转进主页
            self.view.window.rootViewController = [[WXGMainViewController alloc] init];
            
            // 转场动画
            CATransition *anim = [CATransition animation];
            anim.type = kCATransitionFade;
            anim.duration = 0.5;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
        } else {
            // 登录失败，提示用户失败信息
            [self showError:@"用户名或密码错误!!"];
        }
        
        // 停止登录指示器
        [self.loginActivity stopAnimating];
        // 无论登录成功与否，恢复用户交互
        self.view.userInteractionEnabled = YES;
    });
}

/**
 *  登录失败，提示用户失败信息
 *
 *  @param error 失败信息
 */
- (void)showError:(NSString *)error {
    // 1. 弹出提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:error preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
    // 2. 晃动动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.values = @[@-5, @0, @5, @0];
    anim.repeatCount = 3;
    anim.duration = 0.1;
    [self.loginView.layer addAnimation:anim forKey:nil];
}

/**
 *  点击记住密码按钮
 */
- (IBAction)rememberPwd:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    // 关联自动登录按钮
    if (!sender.isSelected) {
        self.autoLoginBtn.selected = NO;
    }
}

/**
 *  点击自动登录按钮
 */
- (IBAction)autoLogin:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    // 关联记住密码按钮
    if (sender.isSelected) {
        self.remPwdBtn.selected = YES;
    }
}

#pragma mark - 文本框的代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountField) {
        // 帐号文本框，去下一项
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        // 密码文本框，执行登录
        [self login];
    }
    
    return YES;
}

@end
