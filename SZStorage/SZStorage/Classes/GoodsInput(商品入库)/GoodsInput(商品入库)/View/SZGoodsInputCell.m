//
//  SZGoodsInputCell.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsInputCell.h"

@interface SZGoodsInputCell ()

@property (weak, nonatomic) IBOutlet UIView *moreContentView;

@end

@implementation SZGoodsInputCell

- (void)awakeFromNib
{
    [super awakeFromNib];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SZGoodsInputCell *cell = [tableView  dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
