//
//  SZCoverView.h
//  SZStorage
//
//  Created by 吴园平 on 18/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCoverView;
@protocol SZCoverViewDelegate <NSObject>

- (void)coverViewDidClose:(SZCoverView *)coverView;

@end

@interface SZCoverView : UIView

@property (nonatomic,weak) id<SZCoverViewDelegate> delegate;

//全屏
+ (instancetype)showCover;

//非全屏
+ (instancetype)showOrderAndSelectCover;



@end
