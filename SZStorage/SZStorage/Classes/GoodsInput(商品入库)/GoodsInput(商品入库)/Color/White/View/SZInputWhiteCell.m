//
//  SZInputWhiteCell.m
//  SZStorage
//
//  Created by 吴园平 on 27/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZInputWhiteCell.h"

@interface SZInputWhiteCell ()
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
//数量
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;

@end

@implementation SZInputWhiteCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"inputWhite";
    SZInputWhiteCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (IBAction)addBtnClick
{
    
}

- (IBAction)plusBtnClick
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
