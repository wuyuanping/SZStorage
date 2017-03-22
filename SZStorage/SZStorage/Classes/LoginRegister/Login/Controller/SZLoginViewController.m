//
//  SZLoginViewController.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZLoginViewController.h"
#import "SZTabBarController.h"
#import "SZRegisterViewController.h"
#import "SZVerifyPhoneController.h"
#import "SZWeChatLoginController.h"
#import "SZAccountBlindController.h"

@interface SZLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pswTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;

@end

@implementation SZLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _loginBtn.layer.cornerRadius = 5;
    _weChatBtn.layer.cornerRadius = 5;
    _phoneTextFiled.placeholderColor = SZColor(44, 140, 248);
    _pswTextFiled.placeholderColor = SZColor(44, 140, 248);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_phoneTextFiled becomeFirstResponder];
}

- (IBAction)login
{
    [_phoneTextFiled resignFirstResponder];
    [_pswTextFiled resignFirstResponder];
    if (_phoneTextFiled.text.length && _pswTextFiled.text.length) {
        if (![SZSystemInfo validateMobile:_phoneTextFiled.text]) {
            [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
            return;
        }
        if (![SZSystemInfo validatePassword:_pswTextFiled.text]) {
            [SVProgressHUD showInfoWithStatus:@"密码格式不对"];
            return;
        }
        NSDictionary *dic = @{
                              @"username":_phoneTextFiled.text,
                              @"password":_pswTextFiled.text,
                              };
        [SZHttpsRequest postJSONWithURL:userLoginUrl params:dic success:^(id responseJSON) {
            if ([responseJSON[@"code"] isEqual:@(0)]) {
                NSLog(@"用户登录成功");
                [[NSUserDefaults standardUserDefaults] setObject:_phoneTextFiled.text forKey:@"username"];
                // 进入账号绑定页面
                SZAccountBlindController *accountVC = [[SZAccountBlindController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = accountVC;
                [[NSUserDefaults standardUserDefaults] synchronize];
                           }else{
                [SVProgressHUD showInfoWithStatus:@"账号或密码错误"];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"手机号或者密码均不能为空"];
        return;
    }
}

- (IBAction)forgetPassword:(id)sender
{
    [self toDOresignFirstResponder];
    //进入忘记密码页面
    SZVerifyPhoneController *verifyPhoneVC = [[SZVerifyPhoneController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = verifyPhoneVC;
}

- (IBAction)newUserRegisterBtnClick
{
    [self toDOresignFirstResponder];
    SZRegisterViewController *registerVC = [[SZRegisterViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = registerVC;
}

- (IBAction)weChatBtnClick
{
    [self toDOresignFirstResponder];
    //TODO :集成微信登录
    SZTabBarController *tabBarVC = [[SZTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    //tabBarVC.selectedIndex = 4;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self toDOresignFirstResponder];
}

- (void)toDOresignFirstResponder
{
    [_phoneTextFiled resignFirstResponder];
    [_pswTextFiled resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
