//
//  SZCoverView.m
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZCoverView.h"

@implementation SZCoverView

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    //发出通知(匿名通知)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeCover" object:nil];
    if ([self.delegate respondsToSelector:@selector(coverViewDidClose:)]) {
        [self.delegate coverViewDidClose:self];
    }
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

+ (instancetype)showOrderAndSelectCover
{
    SZCoverView *cover = [[self alloc] init];
    cover.frame = CGRectMake(0, 163, SCREEN_W, SCREEN_H - 163);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.5;
    //显示到最上方向东西都是添加到主窗口上的.
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}


@end
