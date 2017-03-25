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
static NSString *username = nil;
static NSString *shop_no = nil;
@implementation SZSupplierDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadData];
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
    [self addRightEditSupplierBtn];
}

- (void)loadData
{
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    shop_no = [[NSUserDefaults standardUserDefaults] objectForKey:@"shop_no"];
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":shop_no,
                          @"supplie_no":@"1"
                          };
    [SZHttpsRequest postJSONWithURL:SelectPersonalSupplierUrl params:dic success:^(id responseJSON) {
        if ([responseJSON[@"code"] isEqual:@(0)]) {
            NSLog(@"查询供应商详情成功");
            NSLog(@"%@,%@",responseJSON[@"data"],[NSThread currentThread]); //主线程
            _supplierNamefiled.placeholder = responseJSON[@"data"][@"supplier_name"];
            _connectNameFiled.placeholder = responseJSON[@"data"][@"contact"];
            _ConnectPhoneFiled.placeholder = responseJSON[@"data"][@"contact_mobile"];
            _addressFiled.placeholder = responseJSON[@"data"][@"supplier_address"];
            [self.view setNeedsLayout];
            [self.view setNeedsDisplay];
        }else{
            NSLog(@"查询供应商详情失败");
        }
    } failure:nil];
}

- (void)addRightEditSupplierBtn
{
    UIBarButtonItem *pencil = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_编辑供应商") selImage:IMAGE_NAMED(@"icon_商品管理_编辑供应商") target:self action:@selector(editSupplierClick)];
    self.navigationItem.rightBarButtonItem = pencil;
}

- (void)editSupplierClick
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"编辑供应商";
    _supplierNamefiled.userInteractionEnabled = YES;
    _connectNameFiled.userInteractionEnabled = YES;
    _ConnectPhoneFiled.userInteractionEnabled = YES;
    _addressFiled.userInteractionEnabled = YES;
    _saveBtn.hidden = NO;
}

- (IBAction)saveBtnClick
{
    _saveBtn.hidden = YES;
    [self addRightEditSupplierBtn];
    _supplierNamefiled.userInteractionEnabled = NO;
    _connectNameFiled.userInteractionEnabled = NO;
    _ConnectPhoneFiled.userInteractionEnabled = NO;
    _addressFiled.userInteractionEnabled = NO;
    //将数据上传服务器保存
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":shop_no,
                          @"supplyinfo":@{
                                  @"id":@(1),
                                  @"shop_no":@(10),
                                  @"supplier_no":@(10),
                                  @"supplier_name":_supplierNamefiled.text,
                                  @"supplier_address":_addressFiled.text,
                                  @"contact":_connectNameFiled.text,
                                  @"contact_mobile":_ConnectPhoneFiled.text,
                                  @"description":@"",
                                  @"remark":@""
                           }
                          };
    [SZHttpsRequest postJSONWithURL:supplierModifeUrl params:dic success:^(id responseJSON) {
        if ([responseJSON[@"code"] isEqual:@(0)]) {
            NSLog(@"修改供应商详情成功");
            NSLog(@"%@,%@",responseJSON[@"data"],[NSThread currentThread]);
        }else{
            NSLog(@"修改供应商详情失败%@",responseJSON);
        }
    } failure:nil];
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
