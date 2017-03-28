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
//单位label
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
//类型label
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
//颜色label
@property (weak, nonatomic) IBOutlet UILabel *ColorLabel;
//尺寸label
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

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
    
    [self addObserver];
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectUnitPiece:) name:@"selectUnitPiece" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectUnitCase:) name:@"selectUnitCase" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectUnitTwin:) name:@"selectUnitTwin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectUnitOne:) name:@"selectUnitOne" object:nil];
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUnitPiece" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUnitCase" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUnitTwin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"selectUnitOne" object:nil];
}

- (void)selectUnitPiece:(NSNotification *)note
{
    _unitLabel.text = note.userInfo[@"unit"];
}

- (void)selectUnitCase:(NSNotification *)note
{
    _unitLabel.text = note.userInfo[@"unit"];
}
- (void)selectUnitTwin:(NSNotification *)note
{
    _unitLabel.text = note.userInfo[@"unit"];
}
- (void)selectUnitOne:(NSNotification *)note
{
    _unitLabel.text = note.userInfo[@"unit"];
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
            [self pressetColorVC];
//            _colorVC = [[SZColorController alloc] init];
//            _colorVC.view.frame =
//            [self presentViewController:_colorVC animated:YES completion:nil];
            
            
            
            }
        }
    NSLog(@"点击了:%zd",indexPath.row);
}

- (void)pressetColorVC
{
    //手动实现modal效果
    _colorVC = [[SZColorController alloc] init];
    _colorVC.view.frame = CGRectMake(0, SCREEN_H - 224, SCREEN_W, 224);
    //1.获取主窗口,并在主窗口并显示
    [[UIApplication sharedApplication].keyWindow addSubview:_colorVC.view];

    CGRect frame = _colorVC.view.frame;
    frame.origin.y = SCREEN_H;
    _colorVC.view.frame = frame;
    
    //再通过动画改变高度
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _colorVC.view.frame;
        frame.origin.y = SCREEN_H - 224;
        _colorVC.view.frame = frame;
    } completion:^(BOOL finished) {

    }];
}

- (void)dismissVC
{
    [_colorVC.view removeFromSuperview];
}

#pragma mark - 遮盖代理方法
- (void)coverViewDidClose:(SZCoverView *)coverView
{
    //1.把单位选择view移除
    [SZUnitView hiddenUnitViewCompletion:^{
        //移除遮盖
        [coverView removeFromSuperview];
    }];
    //2.移除颜色控制器
    [self dismissVC];
    [coverView removeFromSuperview];
}

- (void)dealloc
{
    [self removeObserver];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
