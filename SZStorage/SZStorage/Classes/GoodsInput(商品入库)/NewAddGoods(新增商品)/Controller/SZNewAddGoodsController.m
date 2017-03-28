//
//  SZNewAddGoodsController.m
//  SZStorage
//
//  Created by 吴园平 on 19/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZNewAddGoodsController.h"
#import "SZUnitView.h"
#import "SZCoverView.h"
#import "SZColorController.h"
#import "SZGoodsManagerController.h"
#import "SZGoodsSpecificationController.h"

@interface SZNewAddGoodsController ()<SZCoverViewDelegate,UITextFieldDelegate>
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
//规格成本
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
//每个规格批发价
@property (weak, nonatomic) IBOutlet UILabel *costPiFaLabel;
//每个规格库存
@property (weak, nonatomic) IBOutlet UILabel *storageSumLabel;
//总库存
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameFiled;


@end
static NSInteger costLabel = 140;
static NSInteger costPiFaLabel = 160;
static NSInteger storageSumLabel = 250;
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
    _goodsNameFiled.delegate = self;
    
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
    [SVProgressHUD showInfoWithStatus:@"待完善"];
}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 10;
    }
    return 0;
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - UITabelDelegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [SVProgressHUD showInfoWithStatus:@"待完善"];
        }
        if (indexPath.row == 1) {
            [SVProgressHUD showInfoWithStatus:@"待完善"];
        }
        if (indexPath.row == 2) {
            SZCoverView *coverV =  [SZCoverView showCover];
            coverV.delegate = self;
            [SZUnitView showUnitView];
        }
        if (indexPath.row == 3) {
            [SVProgressHUD showInfoWithStatus:@"待完善"];
        }
        if (indexPath.row == 4) {
            SZCoverView *coverV =  [SZCoverView showCover];
            coverV.delegate = self;
            [self pressetColorVC];
            }
        }
    if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            //进入商品规格设置
            SZGoodsSpecificationController  *specificationVC = [[SZGoodsSpecificationController alloc] init];
            [self.navigationController pushViewController:specificationVC animated:YES];
        }
    }
    
    
    [self.view endEditing:YES];
}

- (void)pressetColorVC
{
    //手动实现modal效果
    _colorVC = [[SZColorController alloc] init];
    _colorVC.view.frame = CGRectMake(0, SCREEN_H - 224, SCREEN_W, 224);
    [[UIApplication sharedApplication].keyWindow addSubview:_colorVC.view];
    CGRect frame = _colorVC.view.frame;
    frame.origin.y = SCREEN_H;
    _colorVC.view.frame = frame;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _colorVC.view.frame;
        frame.origin.y = SCREEN_H - 224;
        _colorVC.view.frame = frame;
    } completion:nil];
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

//规格成本加一
- (IBAction)costAddBtnClick
{
    costLabel ++;
    _costLabel.text = [NSString stringWithFormat:@"%ld",(long)costLabel];
}

//规格成本减一
- (IBAction)costMinusBtnClick
{
    costLabel --;
    _costLabel.text = [NSString stringWithFormat:@"%ld",(long)costLabel];
}

//每个规格批发价加一
- (IBAction)costPiFaAddBtnClick
{
    costPiFaLabel ++;
    _costPiFaLabel.text = [NSString stringWithFormat:@"%ld",(long)costPiFaLabel];

}

//每个规格批发价减一
- (IBAction)costPiFaMinusBtnClick
{
    costPiFaLabel --;
    _costPiFaLabel.text = [NSString stringWithFormat:@"%ld",(long)costPiFaLabel];
}

//每个规格库存加一
- (IBAction)storageAddBtnClick
{
    storageSumLabel ++;
    _storageSumLabel.text = [NSString stringWithFormat:@"%ld",(long)storageSumLabel];
    _sumLabel.text = [NSString stringWithFormat:@"%ld",(long)storageSumLabel];
}

//每个规格库存减一
- (IBAction)storageMinusBtnClick
{
    storageSumLabel --;
    if (storageSumLabel == 0) {
        return;
    }
    _storageSumLabel.text = [NSString stringWithFormat:@"%ld",(long)storageSumLabel];
    _sumLabel.text = [NSString stringWithFormat:@"%ld",(long)storageSumLabel];

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _goodsNameFiled.placeholder = textField.text;
}

- (void)dealloc
{
    [self removeObserver];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
