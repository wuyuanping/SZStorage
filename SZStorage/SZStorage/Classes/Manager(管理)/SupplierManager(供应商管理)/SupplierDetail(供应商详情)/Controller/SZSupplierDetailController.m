//
//  SZSupplierDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSupplierDetailController.h"

@interface SZSupplierDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *supplierNamefiled;
@property (weak, nonatomic) IBOutlet UITextField *connectNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *ConnectPhoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *addressFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;


@end

@implementation SZSupplierDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"供应商详情";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _supplierNamefiled.userInteractionEnabled = NO;
    _connectNameFiled.userInteractionEnabled = NO;
    _ConnectPhoneFiled.userInteractionEnabled = NO;
    _addressFiled.userInteractionEnabled = NO;
    _saveBtn.hidden = YES;
    
    //TODO设置导航条右边按钮为： 编辑供应商
    //1.白色笔
    UIBarButtonItem *pencil = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_编辑") selImage:IMAGE_NAMED(@"icon_商品管理_编辑") target:self action:@selector(editSupplierClick)];
    //2.编辑按钮
//    UIBarButtonItem *edit = [UIBarButtonItem itemWithTitle:@"编辑供应商" color:[UIColor whiteColor] action:@selector(editSupplierClick)];
    self.navigationItem.rightBarButtonItems = @[pencil];
}

- (void)editSupplierClick
{
    _supplierNamefiled.userInteractionEnabled = YES;
    _connectNameFiled.userInteractionEnabled = YES;
    _ConnectPhoneFiled.userInteractionEnabled = YES;
    _addressFiled.userInteractionEnabled = YES;
    _saveBtn.hidden = NO;
}

- (IBAction)saveBtnClick
{
    //将数据上传服务器保存
    _saveBtn.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
