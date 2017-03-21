//
//  SZManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZManagerController.h"
#import "SZCustomerManagerController.h"
#import "SZStaffManagerController.h"
#import "SZSupplierManagerController.h"


@interface SZManagerController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation SZManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"管理";
    self.view.backgroundColor = SZColor(240, 240, 240);
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
}

//商品管理
- (IBAction)goodsManager
{

}

//入库单
- (IBAction)inputList
{

}

//店铺管理
- (IBAction)storageManager
{

}

//属性设置
- (IBAction)propertySetting
{

}

//客户管理
- (IBAction)customerManagerBtnClick
{
    SZCustomerManagerController *customerMgVC = [[SZCustomerManagerController alloc] init];
    [self.navigationController pushViewController:customerMgVC animated:YES];
}

//供应商管理
- (IBAction)supplierManager
{
    SZSupplierManagerController *supplierManVC = [[SZSupplierManagerController alloc] init];
    [self.navigationController pushViewController:supplierManVC animated:YES];
}

//员工管理
- (IBAction)staffManager
{
    SZStaffManagerController *staManVC = [[SZStaffManagerController alloc] init];
    [self.navigationController pushViewController:staManVC animated:YES];
}

//个人信息
- (IBAction)personalInfo
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
