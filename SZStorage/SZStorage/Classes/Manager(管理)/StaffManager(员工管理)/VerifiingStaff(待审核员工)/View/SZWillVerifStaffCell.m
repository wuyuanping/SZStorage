//
//  SZWillVerifStaffCell.m
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZWillVerifStaffCell.h"

@interface SZWillVerifStaffCell ()
@property (weak, nonatomic) IBOutlet UILabel *staffNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *staffPhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation SZWillVerifStaffCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    _refuseBtn.layer.cornerRadius = 5;
    _addBtn.layer.cornerRadius = 5;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"cell";
    SZWillVerifStaffCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (IBAction)refuseBtnClick
{

}

- (IBAction)addBtnClick
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
