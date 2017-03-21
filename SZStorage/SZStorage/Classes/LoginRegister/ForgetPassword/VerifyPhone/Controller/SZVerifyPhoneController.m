//
//  SZVerifyPhoneController.m
//  SZStorage
//
//  Created by 吴园平 on 11/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZVerifyPhoneController.h"
#import "SZResetPasswordController.h"
#import "SZLoginViewController.h"

@interface SZVerifyPhoneController ()



@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *MSVerifyFiled;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

static NSString *registerPhoneNumber = nil;
static NSString *verifyCode = nil;
@implementation SZVerifyPhoneController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _getVerifyCodeBtn.layer.cornerRadius = 5;
    _nextStepBtn.layer.cornerRadius = 5;
    _phoneFiled.placeholderColor = SZColor(44, 140, 248);
    _MSVerifyFiled.placeholderColor = SZColor(44, 140, 248);
}

- (IBAction)getVerifyCode
{
    [_phoneFiled resignFirstResponder];
    if (![SZSystemInfo validateMobile:_phoneFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    registerPhoneNumber = _phoneFiled.text;
    //TODO:发送手机号给服务器
    NSDictionary *dic = @{
                          @"mobile":_phoneFiled.text,
                          };
    [SZHttpsRequest postJSONWithURL:verifyCodeUrl params:dic success:^(id responseJSON) {
        NSLog(@"验证码:%@",responseJSON[@"data"][@"verification_code"]);
        verifyCode = responseJSON[@"data"][@"verification_code"];
        // 发送验证码给用户
        [SVProgressHUD showInfoWithStatus:responseJSON[@"data"][@"verification_code"]];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)nextStep
{
    [_phoneFiled resignFirstResponder];
    [_MSVerifyFiled resignFirstResponder];
    if (_phoneFiled.text.length && _MSVerifyFiled.text.length) {
    if (![SZSystemInfo validateVerifyCode:_MSVerifyFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"验证码格式错误"];
        return;
    }
    if (![_MSVerifyFiled.text isEqualToString:verifyCode]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的验证码"];
        return;
    }
    if (![SZSystemInfo validateMobile:_phoneFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号格式错误"];
        return;
    }
    if (![_phoneFiled.text isEqualToString:registerPhoneNumber]) {
        [SVProgressHUD showInfoWithStatus:@"手机号不是注册手机号"];
        return;
    }
        //进入密码重置界面
        SZResetPasswordController *resetVC = [[SZResetPasswordController alloc] init];
        resetVC.verifyCode = verifyCode;
        resetVC.number = _phoneFiled.text;
        [UIApplication sharedApplication].keyWindow.rootViewController = resetVC;
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"手机号或者验证码不能为空"];
        return;
    }
    
}

- (IBAction)returnBtnClick
{
    // 返回登录界面
    SZLoginViewController *loginVC = [[SZLoginViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_phoneFiled resignFirstResponder];
    [_MSVerifyFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
