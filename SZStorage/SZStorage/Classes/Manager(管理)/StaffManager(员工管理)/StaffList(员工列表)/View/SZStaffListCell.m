//
//  SZStaffListCell.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZStaffListCell.h"

@interface SZStaffListCell ()

@property (weak, nonatomic) IBOutlet UILabel *staffNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *staffPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation SZStaffListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"cell";
    SZStaffListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
