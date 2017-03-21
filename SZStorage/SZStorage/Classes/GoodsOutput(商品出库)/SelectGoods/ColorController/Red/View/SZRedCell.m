//
//  SZRedCell.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZRedCell.h"

@interface SZRedCell ()
@property (weak, nonatomic) IBOutlet UILabel *SizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@end

@implementation SZRedCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"red";
    SZRedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (IBAction)minusBtnClick
{

}

- (IBAction)addBtnClick
{

}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
