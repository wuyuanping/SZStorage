//
//  SZCustomerDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerDetailController.h"
//#import "SZCustomerDetilItem.h"

@interface SZCustomerDetailController ()
@property (weak, nonatomic) IBOutlet UITextField *customerNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *connectPersonFiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneFiled;
//客户标签
@property (weak, nonatomic) IBOutlet UILabel *customerTag;
@property (weak, nonatomic) IBOutlet UITextField *addressFiled;

@end

@implementation SZCustomerDetailController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"客户详情";
}

- (void)loadData
{
    //TODO：customer_no 什么鬼？？？
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSDictionary *dic = @{
                          @"username":username,
                          @"shop_no":@(10),
                          @"customer_no":@(10)
                          };
    [SZHttpsRequest postJSONWithURL:customerPersonalDetailUrl params:dic success:^(id responseJSON) {
        if ([responseJSON[@"code"] isEqual:@(0)]) {
            NSLog(@"查询个人信息成功%@",responseJSON[@"data"]);
            NSLog(@"%@",[NSThread currentThread]); //主线程
                _customerNameFiled.text = responseJSON[@"data"][@"customer_name"];
                _phoneFiled.text = responseJSON[@"data"][@"customer_mobile"];
                _addressFiled.text = responseJSON[@"data"][@"customer_address"];
                [self.view setNeedsLayout];
                [self.view setNeedsDisplay];
        }else{
            NSLog(@"查询个人信息失败");
        }
    } failure:nil];
}

- (IBAction)customerBtnClick
{

}

//- (void)setItem:(SZCustomerDetilItem *)item
//{
//    if (item) {
//        
//        //TODO:其他参数
//    }
//}

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
