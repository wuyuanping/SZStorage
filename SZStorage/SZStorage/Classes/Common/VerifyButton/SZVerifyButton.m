//
//  SZVerifyButton.m
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZVerifyButton.h"

@implementation SZVerifyButton

static int timerCount = 59;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        timerCount = 59;
    }
    return self;
}

- (void)beginTimer
{
    timerCount = 59;
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    }
    _timeStart = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(verifyButton:WillBeginTimer:)]) {
        [_delegate verifyButton:self WillBeginTimer:NO];
    }
}

- (void)timerChange
{
    [self setUserInteractionEnabled:NO];
    [self setTitle:[NSString stringWithFormat:@"%ds后重新获取",timerCount] forState:UIControlStateNormal];
    timerCount--;
    if (timerCount == -1) {
        [self refreshTimer];
    }
}

- (void)stoptimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
        [self setUserInteractionEnabled:YES];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        if (_delegate && [_delegate respondsToSelector:@selector(verifyButton:WillEndTimer:)]) {
            [_delegate verifyButton:self WillEndTimer:NO];
        }
    }
}

- (void)refreshTimer
{
    [_timer invalidate];
    _timer = nil;
    [self setTitle:@"重新获取" forState:UIControlStateNormal];
    [self setUserInteractionEnabled:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(verifyButton:WillEndTimer:)]) {
        [_delegate verifyButton:self WillEndTimer:NO];
    }
}

- (void)dealloc
{
    timerCount = 59;
    [_timer invalidate];
    _timer = nil;
}


@end
