//
//  SZGoodsInputHeaderView.m
//  SZStorage
//
//  Created by 吴园平 on 26/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsInputHeaderView.h"

@interface SZGoodsInputHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//库存
@property (weak, nonatomic) IBOutlet UILabel *goodsSumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selecedImage;


@end

@implementation SZGoodsInputHeaderView

+ (instancetype)viewForXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}



@end
