//
//  SZUnitView.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZUnitView.h"

@interface SZUnitView ()
//件
@property (weak, nonatomic) IBOutlet UIButton *pieceBtn;
//盒
@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
//双
@property (weak, nonatomic) IBOutlet UIButton *twinBtn;
//只
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;

@property (weak, nonatomic) IBOutlet UIImageView *pieceImage;
@property (weak, nonatomic) IBOutlet UILabel *pieceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *caseImage;
@property (weak, nonatomic) IBOutlet UILabel *caseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twinImage;
@property (weak, nonatomic) IBOutlet UILabel *twinLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

//@property (nonatomic,assign) BOOL isFirst;  //TODO

@end

@implementation SZUnitView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addTargets];
    [self pieceBtnClick];
}

- (void)addTargets
{
    [_pieceBtn addTarget:self action:@selector(pieceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_caseBtn addTarget:self action:@selector(caseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_twinBtn addTarget:self action:@selector(twinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pieceBtnClick
{
    _pieceImage.hidden = NO;
    _pieceLabel.textColor = SZColor(55, 150, 255);
    _caseImage.hidden = YES;
    _caseLabel.textColor = SZColor(112, 112, 112);
    _twinImage.hidden = YES;
    _twinLabel.textColor = SZColor(112, 112, 112);
    _oneImage.hidden = YES;
    _oneLabel.textColor = SZColor(112, 112, 112);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectUnitPiece" object:nil userInfo:@{@"unit":@"件"}];
}

- (void)caseBtnClick
{
    _pieceImage.hidden = YES;
    _pieceLabel.textColor = SZColor(112, 112, 122);
    _caseImage.hidden = NO;
    _caseLabel.textColor = SZColor(55, 150, 255);
    _twinImage.hidden = YES;
    _twinLabel.textColor = SZColor(112, 112, 112);
    _oneImage.hidden = YES;
    _oneLabel.textColor = SZColor(112, 112, 112);
 [[NSNotificationCenter defaultCenter] postNotificationName:@"selectUnitCase" object:nil userInfo:@{@"unit":@"盒"}];
}

- (void)twinBtnClick
{
    _pieceImage.hidden = YES;
    _pieceLabel.textColor = SZColor(112, 112, 112);
    _caseImage.hidden = YES;
    _caseLabel.textColor = SZColor(112, 112, 112);
    _twinImage.hidden = NO;
    _twinLabel.textColor = SZColor(55, 150, 255);
    _oneImage.hidden = YES;
    _oneLabel.textColor = SZColor(112, 112, 112);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectUnitTwin" object:nil userInfo:@{@"unit":@"双"}];
}

- (void)oneBtnClick
{
    _pieceImage.hidden = YES;
    _pieceLabel.textColor = SZColor(112, 112, 112);
    _caseImage.hidden = YES;
    _caseLabel.textColor = SZColor(112, 112, 112);
    _twinImage.hidden = YES;
    _twinLabel.textColor = SZColor(112, 112, 112);
    _oneImage.hidden = NO;
    _oneLabel.textColor = SZColor(55, 150, 255);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectUnitOne" object:nil userInfo:@{@"unit":@"只"}];
}

+ (void) showUnitView
{
    //1.加载xib的view
    SZUnitView *unitView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SZUnitView class]) owner:nil options:nil] lastObject];
    //2.弹出View（根据modal的底层实现modal效果）
    unitView.tag = 1;
    unitView.yp_y = SCREEN_H;
    unitView.yp_width = SCREEN_W;
    [[UIApplication sharedApplication].keyWindow addSubview:unitView];
    [UIView animateWithDuration:0.25 animations:^{
        unitView.yp_y = SCREEN_H - unitView.yp_height;
    }];
}

+ (void)hiddenUnitViewCompletion:(void (^)())completion
{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view viewWithTag:1]) {
            [UIView animateWithDuration:0.25 animations:^{
                view.yp_y = SCREEN_H;
            }completion:^(BOOL finished) {
                //移除单位view
                [view removeFromSuperview];
                //移除遮盖
                if (completion) {
                    completion();
                }
            }];
        }
    }
}





@end
