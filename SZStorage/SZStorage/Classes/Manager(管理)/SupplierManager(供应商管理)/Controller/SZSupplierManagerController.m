//
//  SZSupplierManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZSupplierManagerController.h"
#import "SZSupplierManagerCell.h"
#import "SZSupplierDetailController.h"
#import "SZNewBuildSupplierController.h"

@interface SZSupplierManagerController ()

@end

@implementation SZSupplierManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self loadData];
}

- (void)setup
{
    self.navigationItem.title = @"供应商管理";
    UIBarButtonItem *newBuildSupplier = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_商品管理_添加商品") selImage:IMAGE_NAMED(@"iicon_商品管理_添加商品") target:self action:@selector(newBuildSupplierClick)];
    self.navigationItem.rightBarButtonItems = @[newBuildSupplier];
}

- (void)newBuildSupplierClick
{
    SZNewBuildSupplierController *newBuildSupVC = [[SZNewBuildSupplierController alloc] init];
    [self.navigationController pushViewController:newBuildSupVC animated:YES];
}

- (void)loadData
{
    NSDictionary *dic = @{
                          @"username":@(13979579263),
                          @"shop_no":@(10),
                          @"key_word":@"",
                          @"page_num":@(1),
                          @"page_size":@(10)
                          };
    [SZHttpsRequest postJSONWithURL:supplierSelectUrl params:dic success:^(id responseJSON) {
        if ([responseJSON[@"code"] isEqual:@(0)]) {
            NSLog(@"查询供应商成功");
            NSLog(@"%@",responseJSON[@"data"]);
        }else{
            NSLog(@"查询供应商失败");
        }
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    SZSupplierManagerCell *cell = [SZSupplierManagerCell cellWithTableView:tableView];
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
    SZSupplierDetailController *supplierDeVC = [[SZSupplierDetailController alloc] init];
    [self.navigationController pushViewController:supplierDeVC animated:YES];
}

@end
