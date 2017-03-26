//
//  SZStorageManagerController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZStorageManagerController.h"

@interface SZStorageManagerController ()
@property (weak, nonatomic) IBOutlet UITextField *storageNameFiled;
@property (weak, nonatomic) IBOutlet UILabel *shopNameStarLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNoStarLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateStarLabel;
//店铺编号
@property (weak, nonatomic) IBOutlet UITextField *shop_noFiled;
//店铺有效期（TODO:自定义日期textFiled）
@property (weak, nonatomic) IBOutlet UITextField *shopValidateDataFiled;
@property (weak, nonatomic) IBOutlet UITextField *adressFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SZStorageManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.navigationItem.title = @"店铺管理";
    self.view.backgroundColor = SZColor(240, 240, 240);
    _shopNameStarLabel.hidden = YES;
    _shopNoStarLabel.hidden = YES;
    _DateStarLabel.hidden = YES;
    _saveBtn.hidden = YES;
    _storageNameFiled.userInteractionEnabled = NO;
    _shop_noFiled.userInteractionEnabled = NO;
    _shopValidateDataFiled.userInteractionEnabled = NO;
    _adressFiled.userInteractionEnabled = NO;
    [self addRightEditBtn];
    [_storageNameFiled addTarget:self action:@selector(updateShopNameFiled) forControlEvents:UIControlEventEditingDidEnd];
    [_shop_noFiled addTarget:self action:@selector(updateShopNoFiled) forControlEvents:UIControlEventEditingDidEnd];
    [_shopValidateDataFiled addTarget:self action:@selector(updateDateFiled) forControlEvents:UIControlEventEditingDidEnd];
    [_adressFiled addTarget:self action:@selector(updateAddressFiled) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)updateShopNameFiled
{
    _storageNameFiled.placeholder = _storageNameFiled.text;
}

- (void)updateShopNoFiled
{
    _shop_noFiled.placeholder = _shop_noFiled.text;
}

- (void)updateDateFiled
{
    _shopValidateDataFiled.placeholder = _shopValidateDataFiled.text;
}

- (void)updateAddressFiled
{
    _adressFiled.placeholder = _adressFiled.text;
}

- (void)addRightEditBtn
{
    UIBarButtonItem *editBtn = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") selImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") target:self action:@selector(editBtnClick)];
    self.navigationItem.rightBarButtonItem = editBtn;
}

- (void)editBtnClick
{
    _shopNameStarLabel.hidden = NO;
    _shopNoStarLabel.hidden = NO;
    _DateStarLabel.hidden = NO;
    _saveBtn.hidden = NO;
    _storageNameFiled.userInteractionEnabled = YES;
    _shop_noFiled.userInteractionEnabled = YES;
    _shopValidateDataFiled.userInteractionEnabled = YES;
    _adressFiled.userInteractionEnabled = YES;
    self.navigationItem.title = @"编辑店铺";
    self.navigationItem.rightBarButtonItem = nil;
}

- (IBAction)saveBtnClick
{
    [self addRightEditBtn];
    _shopNameStarLabel.hidden = YES;
    _shopNoStarLabel.hidden = YES;
    _DateStarLabel.hidden = YES;
    _saveBtn.hidden = YES;
    _storageNameFiled.userInteractionEnabled = NO;
    _shop_noFiled.userInteractionEnabled = NO;
    _shopValidateDataFiled.userInteractionEnabled = NO;
    _adressFiled.userInteractionEnabled = NO;
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
