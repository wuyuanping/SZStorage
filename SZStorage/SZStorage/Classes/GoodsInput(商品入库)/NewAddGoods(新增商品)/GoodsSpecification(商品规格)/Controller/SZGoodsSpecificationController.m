//
//  SZGoodsSpecificationController.m
//  SZStorage
//
//  Created by 吴园平 on 28/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsSpecificationController.h"
#import "SZGoodsSpecificationCell.h"

@interface SZGoodsSpecificationController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *itemArr;

@end

@implementation SZGoodsSpecificationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"商品规格";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _itemArr = @[@"白色 M",@"白色 L",@"黑色 M",@"黑色 L"];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZGoodsSpecificationCell *cell = [SZGoodsSpecificationCell cellWithTableView:tableView];
    //TODO
    cell.item = _itemArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
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
