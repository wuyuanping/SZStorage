//
//  SZUnitView.h
//  SZStorage
//
//  Created by 吴园平 on 24/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZUnitView : UIView

/*
 * 弹出单位View
 */
+ (void)showUnitView;

/*
 * 隐藏单位View
 */
+ (void)hiddenUnitViewCompletion:(void (^)())completion;

@end
