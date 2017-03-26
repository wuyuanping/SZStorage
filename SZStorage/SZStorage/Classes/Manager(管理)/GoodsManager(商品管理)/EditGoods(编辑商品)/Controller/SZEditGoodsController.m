//
//  SZEditGoodsController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZEditGoodsController.h"

@interface SZEditGoodsController ()
@property (strong, nonatomic) IBOutlet SZBaseTableView *contentTableView;
@property (nonatomic,strong) UIView *BtnView;

@end

@implementation SZEditGoodsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"编辑商品";
    _BtnView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 108, SCREEN_W, 44)];
    [self.contentTableView addSubview:_BtnView];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(0, 0, SCREEN_W * 0.5, 44);
    deleteBtn.backgroundColor = [UIColor redColor];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = SYSTEM_FONT(16);
    deleteBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_BtnView addSubview:deleteBtn];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(SCREEN_W * 0.5, 0, SCREEN_W * 0.5, 44);
    saveBtn.backgroundColor = SZColor(46, 144, 255);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = SYSTEM_FONT(16);
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_BtnView addSubview:saveBtn];
}

- (void)deleteBtnClick
{

}

- (void)saveBtnClick
{

}

#pragma mark - Table view data source
//头视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
        return 0;
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
