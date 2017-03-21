//
//  SZRootVCTool.m
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZRootVCTool.h"
#import "SZSaveTool.h"
#import "SZNewFeatureController.h"
#import "SZADViewController.h"

#define YPVersion @"version"
@implementation SZRootVCTool

+ (UIViewController *)chooseRootVC
{
    //获取版本号
    NSString *cur = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //获取上一次版本号
    NSString *preV = [SZSaveTool objectForKey:YPVersion];
    
    //如果说当前版本与上一次版本相同时,进入主框架
    if ([cur isEqualToString:preV]){
        SZADViewController *ADVC = [[SZADViewController alloc] init];
        return ADVC;
    }else{
        //不同时，进入新特性
        SZNewFeatureController *newVC = [[SZNewFeatureController alloc] init];
        [SZSaveTool setObject:cur forKey:YPVersion];
        return newVC;
    }
}

@end
