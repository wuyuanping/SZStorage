//
//  SZVerifyButton.h
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZVerifyButton;
@protocol SZVerifyButtonDelegate <NSObject>

@optional
//please remember invalidate timer when push
- (void)verifyButton:(SZVerifyButton *)wBtn WillBeginTimer:(BOOL)isTimeOn;
- (void)verifyButton:(SZVerifyButton *)wBtn WillEndTimer:(BOOL)isTimeOn;

@end

@interface SZVerifyButton : UIButton

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL timeStart;
@property (nonatomic, assign) id<SZVerifyButtonDelegate>delegate;

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *verifyTitle;

- (void)beginTimer;
- (void)stoptimer;
- (void)refreshTimer;

@end
