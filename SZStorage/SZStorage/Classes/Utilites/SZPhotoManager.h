//
//  SZPhotoManager.h
//  SZStorage
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZPhotoManager : NSObject

/*
 *  保存图片到相册
 */
+ (void)savePhoto:(UIImage *)image
      albumeTitle:(NSString *)albumTitle
completionHandler:(void(^)(BOOL success, NSError * error))completionHandler;

@end
