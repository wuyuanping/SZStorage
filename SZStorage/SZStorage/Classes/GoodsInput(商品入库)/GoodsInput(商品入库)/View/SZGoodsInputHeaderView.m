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


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HeadViewcell";
    SZGoodsInputHeaderView *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//    _selecedImage.image = selected? IMAGE_NAMED(@"icon_商品出库_筛选_打勾"):IMAGE_NAMED(@"icon_商品出库_筛选_选框");
    _selecedImage.hidden = !selected; //有毒！！
}


@end
