//
//  SZGoodsDetailController.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsDetailController.h"
#import "SZEditGoodsController.h"

@interface SZGoodsDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//库存
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

//类别名
@property (weak, nonatomic) IBOutlet UILabel *kindNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
//成本
@property (weak, nonatomic) IBOutlet UILabel *costLabel;


@end

@implementation SZGoodsDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"商品详情";
    UIBarButtonItem *editGoods = [UIBarButtonItem itemWithImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") selImage:IMAGE_NAMED(@"icon_个人信息管理_编辑") target:self action:@selector(editGoodsBtnClick)];
    self.navigationItem.rightBarButtonItem = editGoods;
}

- (void)editGoodsBtnClick
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SZEditGoodsController" bundle:nil];
    SZEditGoodsController *editGoodsVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:editGoodsVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
