//
//  UINavigationBar+CoverView.h
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CoverView)

@property (nonatomic, strong) UIView *coverView;

- (void)setCoverViewBackgroundColor:(UIColor *)color;

- (void)_setElementsAlpha:(CGFloat)alpha;
- (void)_setTranslationY:(CGFloat)translationY;
- (void)_resetCoverView;

@end
