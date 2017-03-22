//
//  SZNewBulidCustomerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZNewBulidCustomerController.h"

@interface SZNewBulidCustomerController ()

@property (weak, nonatomic) IBOutlet UITextField *customerNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *connectNaneFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
@property (weak, nonatomic) IBOutlet UITextField *customerAddressFiled;

@end

@implementation SZNewBulidCustomerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    //TODO :客户标签待完善，先写VIP1
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"新建客户";
}

- (IBAction)saveCustomerBtnClick
{
    //客户信息提交服务器
    NSDictionary *dic = @{
                          @"username":@(13979579263),
                          @"shop_no":@(10),
                          @"customer_info": @{
                          @"customer_no":@(1),
                          @"customer_name": _customerNameFiled.text,
                          @"customer_mobile":_phoneFiled.text,
                          @"customer_address":_customerAddressFiled.text,
                          @"price_label": @"VIP1",
                          @"description":@"",
                          @"remark":@""
                            }
                          };
    [SZHttpsRequest postJSONWithURL:addCustomerUrl params:dic success:^(id responseJSON) {
        NSLog(@"%@",responseJSON[@"code"]);
        if ([responseJSON[@"code"] isEqual: @(0)]) {
            [SVProgressHUD showInfoWithStatus:@"恭喜，客户保存成功"];
        }else{
            NSLog(@"保存失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
