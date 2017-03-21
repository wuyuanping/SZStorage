//
//  SZStoryageVerifyController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZStoryageVerifyController.h"
#import "SZTabBarController.h"
#import "SZJoinExitStorageController.h"
#import "SZCreatePersonalStorageController.h"

@interface SZStoryageVerifyController ()
//审核中占位View
@property (weak, nonatomic) IBOutlet UIView *VerifyingView;
//审核结果不通过View
@property (weak, nonatomic) IBOutlet UIView *VerifedView;
@property (weak, nonatomic) IBOutlet UIButton *DoneBtn;
//审核成功Label
@property (weak, nonatomic) IBOutlet UILabel *verifyResultLabel;

@end

@implementation SZStoryageVerifyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
}

- (void)setup
{
    _VerifedView.hidden = YES;
    //三秒后弹框提示添加成功
    [NSTimer scheduledTimerWithTimeInterval:3.0 block:^(NSTimer * _Nonnull timer) {
        [SVProgressHUD showInfoWithStatus:@"恭喜您，审核已通过"];
        _verifyResultLabel.text = @"请按完成进入主页";
        
        //TODO:也可以不成功，则隐藏判断View，不隐藏失败View
    } repeats:NO];
}

//返回
- (IBAction)reBack
{
    SZJoinExitStorageController *joinExitStorageVC = [[SZJoinExitStorageController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = joinExitStorageVC;
}

//完成
- (IBAction)DoneBtnClick
{
    SZTabBarController *tabVC = [[SZTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSZIsLogined];
}

//创建个人店铺
- (IBAction)createPersonalStrageBtnClick
{
    SZCreatePersonalStorageController *createPerStorageVC = [[SZCreatePersonalStorageController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = createPerStorageVC;
}

//重新加入店铺
- (IBAction)reJoinExitStorage
{
    SZJoinExitStorageController *joinExitStorageVC = [[SZJoinExitStorageController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = joinExitStorageVC;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
