//
//  SZJoinExitStorageController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZJoinExitStorageController.h"
#import "SZAccountBlindController.h"
#import "SZStoryageVerifyController.h"

@interface SZJoinExitStorageController ()
@property (weak, nonatomic) IBOutlet UITextField *storageIDFiled;
@property (weak, nonatomic) IBOutlet UITextField *storyageNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *noteFiled;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SZJoinExitStorageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    _contentView.backgroundColor = SZColor(240, 240, 240);
}

//加入店铺(进入账号审核)
- (IBAction)joinExitStorageBtnClick
{
    SZStoryageVerifyController *storageVerifyVC = [[SZStoryageVerifyController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = storageVerifyVC;
}

//返回
- (IBAction)reback:(id)sender
{
    SZAccountBlindController *accountBlindVC = [[SZAccountBlindController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = accountBlindVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [_storageIDFiled resignFirstResponder];
    [_storyageNameFiled resignFirstResponder];
    [_noteFiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
