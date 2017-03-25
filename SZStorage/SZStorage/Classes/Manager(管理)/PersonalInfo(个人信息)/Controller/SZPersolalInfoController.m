//
//  SZPersolalInfoController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZPersolalInfoController.h"

@interface SZPersolalInfoController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SZPersolalInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"个人详情";
    _saveBtn.hidden = YES;
    _phoneFiled.userInteractionEnabled = NO;
    _nameFiled.userInteractionEnabled = NO;
    //导航条右边添加编辑按钮
    [self addRightEditBtn];
    [_nameFiled addTarget:self action:@selector(updateNameFiled) forControlEvents:UIControlEventEditingDidEnd];
    [_phoneFiled addTarget:self action:@selector(updatePhoneFiled) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)editBtnClick
{
    _saveBtn.hidden = NO;
    _phoneFiled.userInteractionEnabled = YES;
    _nameFiled.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"编辑个人信息";
}

- (void)updateNameFiled
{
    _nameFiled.placeholder = _nameFiled.text;
}

- (void)updatePhoneFiled
{
    if (![SZSystemInfo validateMobile:_phoneFiled.text]) {
        [SVProgressHUD showInfoWithStatus:@"亲，手机号格式错误"];
        return;
    }
    _phoneFiled.placeholder = _phoneFiled.text;
}

- (IBAction)saveBtnClick
{
    [self addRightEditBtn];
    _phoneFiled.userInteractionEnabled = NO;
    _nameFiled.userInteractionEnabled = NO;
    //发送最新个人信息给服务器
    [SVProgressHUD showInfoWithStatus:@"信息待提交服务器"];
    //TODO:
}

- (void)addRightEditBtn
{
    UIBarButtonItem *editBtn = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") selImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") target:self action:@selector(editBtnClick)];
    self.navigationItem.rightBarButtonItem = editBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
