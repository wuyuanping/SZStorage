//
//  SZGoodsManagerCell.m
//  SZStorage
//
//  Created by 吴园平 on 25/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsManagerCell.h"

@interface SZGoodsManagerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *storageSumLabel;

@end

@implementation SZGoodsManagerCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * const ID = @"goodsCell";
    SZGoodsManagerCell *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
