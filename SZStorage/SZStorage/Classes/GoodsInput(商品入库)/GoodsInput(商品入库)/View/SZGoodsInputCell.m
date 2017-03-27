//
//  SZGoodsInputCell.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZGoodsInputCell.h"
#import "SZInputColorController.h"

@interface SZGoodsInputCell ()

@property (weak, nonatomic) IBOutlet UIView *middleContentView;

@end

@implementation SZGoodsInputCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    //添加颜色控制器
    SZInputColorController *colorVC = [[SZInputColorController alloc] init];
    colorVC.view.frame = CGRectMake(0, 0, SCREEN_W, 134);
    [_middleContentView addSubview:colorVC.view];
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
