//
//  SZADItem.h
//  SZStorage
//
//  Created by 吴园平 on 09/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SZADItem : NSObject

/*
 *图片url
 */
@property (nonatomic, strong) NSString *w_picurl;
/*
 *广告URL
 */
@property (nonatomic, strong) NSString *ori_curl;
/*
 *广告图片宽
 */
@property (nonatomic, assign) CGFloat w;

/*
 *广告图片高
 */
@property (nonatomic, assign) CGFloat h;


@end
