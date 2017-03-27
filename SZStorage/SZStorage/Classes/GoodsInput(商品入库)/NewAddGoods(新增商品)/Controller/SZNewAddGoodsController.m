//
//  SZNewAddGoodsController.m
//  SZStorage
//
//  Created by 吴园平 on 19/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZNewAddGoodsController.h"
#import "SZHeaderView.h"
#import "SZUnitView.h"
#import "SZCoverView.h"
#import "SZColorController.h"
#import "SZGoodsManagerController.h"

@interface SZNewAddGoodsController ()<SZCoverViewDelegate>
@property (nonatomic,strong) UIView *BtnView;
@property (strong, nonatomic) IBOutlet SZBaseTableView *contentTableView;
@property (nonatomic,strong) SZColorController *colorVC;

@end

@implementation SZNewAddGoodsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"新增商品";
    _BtnView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 108, SCREEN_W, 44)];
    [self.contentTableView addSubview:_BtnView];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, 0, SCREEN_W * 0.5, 44);
    saveBtn.backgroundColor = SZColor(170, 170, 170);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = SYSTEM_FONT(16);
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_BtnView addSubview:saveBtn];

    UIButton *saveAndAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveAndAddBtn.frame = CGRectMake(SCREEN_W * 0.5, 0, SCREEN_W * 0.5, 44);
    saveAndAddBtn.backgroundColor = SZColor(46, 144, 255);
    [saveAndAddBtn setTitle:@"保存并新增" forState:UIControlStateNormal];
    [saveAndAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveAndAddBtn.titleLabel.font = SYSTEM_FONT(16);
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveAndAddBtn addTarget:self action:@selector(saveAndAddBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_BtnView addSubview:saveAndAddBtn];
}

- (void)saveBtnClick
{
    //跳转到商品管理
    SZGoodsManagerController *goodsManVC = [[SZGoodsManagerController alloc] init];
    [self.navigationController pushViewController:goodsManVC animated:YES];
    //TODO:数据传服务器
}

- (void)saveAndAddBtnClick
{

}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 40;
    }
    return 0;
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//设置头部视图View
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        SZHeaderView *headView = [SZHeaderView viewForXib];
        headView.backgroundColor = SZColor(240 , 240, 240);
        return headView;
    }
    return nil;
}

#pragma mark - UITabelDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            SZCoverView *coverV =  [SZCoverView showCover];
            coverV.delegate = self;
            [SZUnitView showUnitView];
        }
        if (indexPath.row == 4) {
            SZCoverView *coverV =  [SZCoverView showCover];
            coverV.delegate = self;
//            _colorVC = [[SZColorController alloc] init];
//            [self presentViewController:_colorVC animated:YES completion:nil];
            }
        }
    NSLog(@"点击了:%ld",indexPath.row);
}

#pragma mark - 遮盖代理方法
- (void)coverViewDidClose:(SZCoverView *)coverView
{
    //1.把单位选择view移除
    [SZUnitView hiddenUnitViewCompletion:^{
        //移除遮盖
        [coverView removeFromSuperview];
    }];
    [self.navigationController dismissViewControllerAnimated:_colorVC completion:^{
        //移除遮盖
        [coverView removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
