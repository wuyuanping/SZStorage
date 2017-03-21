//
//  SZGoodsInputController.m
//  SZStorage
//
//  Created by 吴园平 on 16/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsInputController.h"
#import "SZNewAddGoodsController.h"
#import "SZInputController.h"

@interface SZGoodsInputController ()
@property (weak, nonatomic) IBOutlet UIView *addGoodsView;
@property (weak, nonatomic) IBOutlet UIView *goodsInputView;

@end

@implementation SZGoodsInputController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.view.backgroundColor = SZColor(240, 240, 240);
    self.navigationItem.title = @"商品入库";
    _addGoodsView.layer.cornerRadius = 7;
    _goodsInputView.layer.cornerRadius = 7;
    _addGoodsView.backgroundColor = SZColor(255, 255, 255);
    _goodsInputView.backgroundColor = SZColor(255, 255, 255);
    [self setNavigationBarBackgroundImage:IMAGE_NAMED(@"icon_导航条") tintColor:SZColor(46, 144, 255) textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
}

//新增商品
- (IBAction)addGoods
{
    UIStoryboard *newAddStoryBoard = [UIStoryboard storyboardWithName:@"SZNewAddGoodsController" bundle:nil];
    SZNewAddGoodsController *newAddVC = [newAddStoryBoard instantiateInitialViewController];
    [self.navigationController pushViewController:newAddVC animated:YES];
}

//商品入库
- (IBAction)goodsInput
{
    SZInputController *inputVC = [[SZInputController alloc] init];
    [self.navigationController pushViewController:inputVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
