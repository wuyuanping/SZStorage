//
//  UIButton+Block.h
//  SZStorage
//
//  Created by 吴园平 on 10/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();
@interface UIButton (Block)

@property (nonatomic, copy) NSString *Type;

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;



@end
