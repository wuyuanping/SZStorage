//
//  SZCreatePersonalStorageController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCreatePersonalStorageController.h"
#import "SZAccountBlindController.h"
#import "SZTabBarController.h"
#import "SZManagerController.h"

@interface SZCreatePersonalStorageController ()
@property (weak, nonatomic) IBOutlet UITextField *storageNameFiled; //店铺名称
@property (weak, nonatomic) IBOutlet UITextField *storageAddressFiled; //店铺地址
@property (strong, nonatomic) IBOutlet UIView *contentView;


@end

static NSString *username = nil;
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
    [_storageNameFiled resignFirstResponder];
    [_storageAddressFiled resignFirstResponder];
    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (_storageNameFiled.text.length && _storageAddressFiled.text.length) {
        //发送创建信息给服务器
        NSDictionary *dic = @{
                              @"username":_username,
                              @"shopinfo":@{
                                      @"shop_name":_storageNameFiled.text,
                                      @"shop_adress":_storageAddressFiled.text,
                                      @"description":@"haha",
                                      @"remark":@"wuwu"
                                      }
                              };
        [SZHttpsRequest postJSONWithURL:createShopUrl params:dic success:^(id responseJSON) {
            if ([responseJSON[@"code"] isEqual:@(0)]) {
                [SVProgressHUD  showInfoWithStatus:@"恭喜，创建店铺成功。"];
                SZTabBarController *tabVC = [[SZTabBarController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
                [[NSUserDefaults standardUserDefaults] setObject:isLogined forKey:kSZIsLogined];
                return ;
            }else{
                 [SVProgressHUD  showInfoWithStatus:@"呜呜~创建店铺没有成功."];
                return ;
            }
        } failure:nil];
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"店铺名称或店铺地址不能为空"];
        return;
    }
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

- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
