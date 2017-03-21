//
//  SZPhotoManager.m
//  SZStorage
//
//  Created by 吴园平 on 13/03/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "SZPhotoManager.h"
#import <Photos/Photos.h>

@implementation SZPhotoManager

#pragma mark - 获取之前的相册
//用于判断新建相册是否存在同名相册。如果存在就返回相同相册名，否则返回nil。
+ (PHAssetCollection *)fetchAssetColletion:(NSString *)albumTitle
{
    //获取之前的相册(相册组)
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *asset in result) {
        if ([asset.localizedTitle isEqualToString:albumTitle]) {
            //存在同名相册，就返回相册名
            return asset;
        }
    }
    return  nil;
}

+ (void)savePhoto:(UIImage *)image
      albumeTitle:(NSString *)albumTitle
completionHandler:(void (^)(BOOL, NSError *))completionHandler
{
    //对照片库进行操作
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1.获取之前相册，再判断之前有没有相册，有就返回
        PHAssetCollection *assetCollection = [self fetchAssetColletion:albumTitle];
        
        PHAssetCollectionChangeRequest *assetCollectionRequest;
        if (assetCollection) {
            //已有相册，(直接在已存在相册中修改图片)
            assetCollectionRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        }else{
            //没有相册,创建新相册，(再在新相册中修改)
            assetCollectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        //2.保存图片到系统相册
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        //3.把创建好的图片添加到相册
        PHObjectPlaceholder *placeHolder = [assetChangeRequest placeholderForCreatedAsset];
        
        //唯一的相册中添加占位图片，内部会自动将图片添加到指定相册
        [assetCollectionRequest addAssets: @[placeHolder]];//占位内存，性能高
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (completionHandler) { //方法一
            completionHandler(success,error);
        }
    }];
}

@end
