//
//  SZCoverView.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCoverView.h"

@implementation SZCoverView

-  (void)showCoverWithFrame:(CGRect)coverFrame PositionToView:(UIView *)view completion:(void (^)())completion
{
    SZCoverView *cover = [[SZCoverView alloc] init];
    cover.frame = coverFrame;
    cover.backgroundColor = [UIColor clearColor];  //治标不治本！！！
    cover.alpha = 1;
    //显示到最上方向东西都是添加到主窗口上的.
    if (view == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:cover];
    }else{
        [self insertSubview:cover aboveSubview:view];
    }
    if (completion) {
        completion();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    //发出通知(匿名通知)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCover" object:nil];
    if ([self.delegate respondsToSelector:@selector(coverViewDidClose:)]) {
        [self.delegate coverViewDidClose:self];
    }
//    [self removeFromSuperview];
}

+ (instancetype)showCover
{
    SZCoverView *cover = [[self alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    //显示到最上方向东西都是添加到主窗口上的.
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}




@end
