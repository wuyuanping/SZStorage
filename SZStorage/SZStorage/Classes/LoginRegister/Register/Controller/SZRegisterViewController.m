//
//  SZRegisterViewController.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZRegisterViewController.h"
#import "SZPasswordViewController.h"
#import "SZLoginViewController.h"

@interface SZRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end
static NSString *verifyCode = nil;
static NSString *registerPhoneNumber = nil;
@implementation SZRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit
{
    _getVerifyBtn.layer.cornerRadius = 5;
    _registerBtn.layer.cornerRadius = 5;
    _phoneTextFiled.placeholderColor = SZColor(44, 140, 248);
    _verifyCodeTextFiled.placeholderColor = SZColor(44, 140, 248);
}
- (IBAction)getVerifyCodeBtnClick
{

    [_phoneTextFiled resignFirstResponder];
    if (![SZSystemInfo validateMobile:_phoneTextFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    registerPhoneNumber = _phoneTextFiled.text;
    // 将正确手机号发送给服务器,服务器返回验证码
    NSDictionary *dic = @{
                          @"mobile":_phoneTextFiled.text,
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

- (IBAction)loginBtnClick
{
    SZLoginViewController *loginVC = [[SZLoginViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}

- (IBAction)registerBtnClick
{
    [_phoneTextFiled resignFirstResponder];
    [_verifyCodeTextFiled resignFirstResponder];
    if (_phoneTextFiled.text.length && _verifyCodeTextFiled.text.length) {
        if (![SZSystemInfo validateMobile:_phoneTextFiled.text]) {
            [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
            return;
        }
        if (![_phoneTextFiled.text isEqualToString:registerPhoneNumber]) {
            [SVProgressHUD showInfoWithStatus:@"手机号错误！"];
            return;
        }
        if (![SZSystemInfo validateVerifyCode:_verifyCodeTextFiled.text]) {
            [SVProgressHUD showInfoWithStatus:@"验证码格式不正确"];
            return;
        }
        if (![_verifyCodeTextFiled.text isEqualToString:verifyCode]) {
            [SVProgressHUD showInfoWithStatus:@"验证码错误!"];
            return;
        }
        //验证码以及手机号正确才进入设置密码页面
        SZPasswordViewController *pswVC = [[SZPasswordViewController alloc] init];
        pswVC.verifyCode = verifyCode;
        pswVC.number = registerPhoneNumber;
        [UIApplication sharedApplication].keyWindow.rootViewController = pswVC;
    }else{
        [SVProgressHUD showInfoWithStatus:@"手机号或密码不能为空"];
        return;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_phoneTextFiled resignFirstResponder];
    [_verifyCodeTextFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
