//
//  SZUnitView.m
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZUnitView.h"

@implementation SZUnitView

+ (void) showUnitView
{
    //1.加载xib的view
    SZUnitView *unitView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SZUnitView class]) owner:nil options:nil] lastObject];
    //2.弹出View（根据modal的底层实现modal效果）
    unitView.yp_y = SCREEN_H;
    unitView.yp_width = SCREEN_W;
//    unitView.yp_height = 236;
    [[UIApplication sharedApplication].keyWindow addSubview:unitView];
    [UIView animateWithDuration:0.25 animations:^{
        unitView.yp_y = SCREEN_H - unitView.yp_height;
    }];
}

+ (void)hiddenUnitViewCompletion:(void (^)())completion
{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[SZUnitView class]]) {
            [UIView animateWithDuration:0.25 animations:^{
                view.yp_y = SCREEN_H;
            }completion:^(BOOL finished) {
                //移除单位view
                [view removeFromSuperview];
                //移除遮盖
                if (completion) {
                    completion();
                }
                //                for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
                //                    if ([view isKindOfClass:[YPCoverView class]]) {
                //                        [view removeFromSuperview];
                //                    }
                //                }
                
                //弹框
                //                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"asdf" message:@"asdfa" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                //                [alertV show];
                
            }];
        }
    }
}



@end
