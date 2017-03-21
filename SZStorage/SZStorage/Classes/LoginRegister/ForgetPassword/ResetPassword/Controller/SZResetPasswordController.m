//
//  SZResetPasswordController.m
//  SZStorage
//
//  Created by 吴园平 on 11/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZResetPasswordController.h"
#import "SZLoginViewController.h"
#import "SZVerifyPhoneController.h"

@interface SZResetPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *NewPasswordFiled;
@property (weak, nonatomic) IBOutlet UITextField *secondNewPswFiled;
@property (weak, nonatomic) IBOutlet UIButton *resetDoneBtn;

@end

@implementation SZResetPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _resetDoneBtn.layer.cornerRadius = 5;
    _NewPasswordFiled.placeholderColor = SZColor(44, 140, 248);
    _secondNewPswFiled.placeholderColor = SZColor(44, 140, 248);
}

- (IBAction)resetDone
{
    [_NewPasswordFiled resignFirstResponder];
    [_secondNewPswFiled resignFirstResponder];
    if (_NewPasswordFiled.text.length && _secondNewPswFiled.text.length) {
    if (![SZSystemInfo validatePassword:_NewPasswordFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码格式不正确"];
        return;
    }
    if (![(_NewPasswordFiled.text) isEqualToString:(_secondNewPswFiled.text)]) {
        [SVProgressHUD showInfoWithStatus:@"密码设置不一致"];
        return;
    }
    //TODO:将注册数据发送给服务器
    NSDictionary *dic = @{
                          @"username":_number,
                          @"verification_code":_verifyCode,
                          @"password":_secondNewPswFiled.text,
                          @"status":@(1),
                          @"create_type":@(2),
                          @"name":_number,
                          @"mobile":_number,
                          @"address":@""
                          };
    [SZHttpsRequest postJSONWithURL:registerUrl params:dic success:^(id responseJSON) {
        NSLog(@"%@",responseJSON);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
        SZLoginViewController *loginVC = [[SZLoginViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
    }else{
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
}

- (IBAction)returnBtnClick
{
    //进入验证手机
    SZVerifyPhoneController *verifyPhoneVC = [[SZVerifyPhoneController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = verifyPhoneVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_NewPasswordFiled resignFirstResponder];
    [_secondNewPswFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
