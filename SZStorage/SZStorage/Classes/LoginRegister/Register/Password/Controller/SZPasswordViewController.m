//
//  SZPasswordViewController.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZPasswordViewController.h"
#import "SZRegisterViewController.h"
#import "SZLoginViewController.h"

@interface SZPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordFiled;
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordFiled;
@property (weak, nonatomic) IBOutlet UIButton *DoneBtn;

@end

@implementation SZPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _passwordFiled.placeholderColor = SZColor(44, 140, 248);
    _secondPasswordFiled.placeholderColor = SZColor(44, 140, 248);
    _DoneBtn.layer.cornerRadius = 5;
}

- (IBAction)registerDone
{
    [_passwordFiled resignFirstResponder];
    [_secondPasswordFiled resignFirstResponder];
    if (![SZSystemInfo validatePassword:_passwordFiled.text]){
        [SVProgressHUD showInfoWithStatus:@"密码格式不正确"];
        return;
    }
    if (![_passwordFiled.text isEqualToString:_secondPasswordFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码不一致"];
        return;
    }
    //将用户账号和密码传给服务器
    NSDictionary *dic = @{
                          @"username":_number,
                          @"verification_code":_verifyCode,
                          @"password":_passwordFiled.text,
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
    //进入登入页面
    SZLoginViewController *loginVC = [[SZLoginViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
}
- (IBAction)reBack
{
    //回到注册页面
    SZRegisterViewController *registerVC = [[SZRegisterViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = registerVC;
}

//- (IBAction)showPassword:(UIButton *)sender
//{
//    sender.selected = !sender.selected;
//    _passwordFiled.secureTextEntry = !sender.selected;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_passwordFiled resignFirstResponder];
    [_secondPasswordFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
