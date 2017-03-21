//
//  SZCustomerManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCustomerManagerController.h"
#import "SZCustomerManagerCell.h"
#import "SZNewBulidCustomerController.h"
#import "SZCustomerDetailController.h"

@interface SZCustomerManagerController ()

@end

@implementation SZCustomerManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

- (void)setup
{
    self.navigationItem.title = @"客户管理";
    UIBarButtonItem *pencil = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_编辑") selImage:IMAGE_NAMED(@"icon_商品管理_编辑") target:self action:@selector(newBulidBtnClick)];
    self.navigationItem.rightBarButtonItems = @[pencil];
}

- (void)loadData
{

    NSDictionary *dic = @{
                          @"username":@(13979579263),
                          @"shop_no":@(10),
                          @"key_word":@"www",
                          @"page_num":@(1),
                          @"page_size":@(3)
                          };
    [SZHttpsRequest postJSONWithURL:selectCustomerUrl params:dic success:^(id responseJSON) {
        NSLog(@"%@",responseJSON[@"code"]);
        NSLog(@"%@",responseJSON);
        [SVProgressHUD showInfoWithStatus:@"报告老板，查询客户成功"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)newBulidBtnClick
{
    SZNewBulidCustomerController *newBuildVC = [[SZNewBulidCustomerController alloc] init];
    [self.navigationController pushViewController:newBuildVC animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZCustomerManagerCell *cell = [SZCustomerManagerCell cellWithTableView:tableView];
    //TODO
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZCustomerDetailController *customerDetVC = [[SZCustomerDetailController alloc] init];
    [self.navigationController pushViewController:customerDetVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
