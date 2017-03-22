//
//  SZNewBuildSupplierController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZNewBuildSupplierController.h"

@interface SZNewBuildSupplierController ()
@property (weak, nonatomic) IBOutlet UITextField *supplierNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *connectNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *supplierAdressFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SZNewBuildSupplierController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"新建供应商";
}

- (IBAction)saveBtnClick
{
    if (_supplierNameFiled.text.length && _connectNameFiled.text.length && _phoneFiled.text.length && _supplierNameFiled.text.length) {
//        if (![SZSystemInfo validateMobile:_phoneFiled.text]) {
//            [SVProgressHUD showInfoWithStatus:@"手机号格式错误"];
//            return;
//        }
        //提交数据至服务器
        NSDictionary *dic = @{
                              @"username":@(13979579263),
                              @"shop_no":@(10),
                              @"supplyinfo":@{
                                      @"supplier_name":_supplierNameFiled.text,
                                      @"supplier_address":_supplierAdressFiled.text,
                                      @"connect":_connectNameFiled.text,
                                      @"contact_mobile":_phoneFiled.text,
                                      @"description":@"",
                                      @"remark":@""
                                      }
                              };
        [SZHttpsRequest postJSONWithURL:supplierAddUrl params:dic success:^(id responseJSON) {
            if ([responseJSON[@"code"] isEqual:@(0)]) {
                [SVProgressHUD showInfoWithStatus:@"添加供应商成功"];
            }
        } failure:nil];
    }else{
        [SVProgressHUD showInfoWithStatus:@"亲，还有未填项哦"];
    }
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
