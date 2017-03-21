//
//  SZFileManager.h
//  SZStorage
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZFileManager : NSFileManager

/*
 *指定一个文件夹路径，获取当前文件夹路径的总大小
 */
+ (void)getDirectorySize:(NSString *)directoryPath
              completion:(void(^)(int totalSize))completion;

/*
 *指定一个文件夹路径,删除这个文件夹
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/*
 *指定一个文件夹路径，直接帮你获取当前文件夹总大小并自定义显示内容
 */
+ (void)directorySizeString:(NSString *)directoryPath
                 completion:(void(^)(NSString * str))strCompletion;

@end
