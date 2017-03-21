//
//  SZCreatePersonalStorageController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCreatePersonalStorageController.h"
#import "SZAccountBlindController.h"

@interface SZCreatePersonalStorageController ()
@property (weak, nonatomic) IBOutlet UITextField *storageNameFiled; //店铺名称
@property (weak, nonatomic) IBOutlet UITextField *storageAddressFiled; //店铺地址
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SZCreatePersonalStorageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _contentView.backgroundColor = SZColor(240, 240, 240);
}

//创建
- (IBAction)createBtnClick
{
    [SVProgressHUD showInfoWithStatus:@"报告老板，店铺正在创建中。。"];
    return;
}

//返回
- (IBAction)reBack
{
    SZAccountBlindController *accountBlindVC = [[SZAccountBlindController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = accountBlindVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_storageNameFiled resignFirstResponder];
    [_storageAddressFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
