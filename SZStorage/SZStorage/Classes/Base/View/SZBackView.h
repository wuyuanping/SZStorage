//
//  SZBackView.h
//  SZStorage
//
//  Created by 吴园平 on 20/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZBackView : UIView

+ (instancetype)backViewWithImage:(UIImage *)image
                        highImage:(UIImage *)highImage
                           target:(id)target
                           action:(SEL)action
                            title:(NSString *)title;

@end
