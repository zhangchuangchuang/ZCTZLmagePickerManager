//
//  WJTZImageManager.h
//  TZImagePickerController
//
//  Created by tqh on 2017/11/15.
//  Copyright © 2017年 谭真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TZImagePickerController.h>
#import <TZImageManager.h>
//#import <YYImage.h>
typedef void (^WJTZImageManagerImageBlock)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto);
typedef void (^WJTZImageManagerImageVideoStringBlock)(NSString *fileString);
typedef void (^WJTZImageManagerImageVideoBlock)(UIImage *coverImage,NSString *fileString);//个人中心资料编辑视频封面
typedef void (^WJTZImageManagerDataBlock)(NSArray *dataAarray);

/**第三方控制器管理,处理一般情况业务逻辑*/
@interface WJTZImageManager : NSObject

/**
 图片视频（只用于个人中心资料）
 */
+ (void)showImageAndVideoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock fileBlock:(WJTZImageManagerImageVideoBlock)fileBlock;
/**
 image多选
 */
+ (void)showImagePhotoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock;
/**
 gif多选(普通类型)
 */
+ (void)showGifImagePhotoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock;
/**
 gif多选(data类型，获取出来的都是原来数据data)
 */
+ (void)showGifImageIDataWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerDataBlock)finishBlock;
/**
 视频单选
 */
+ (void)showVideoImagePhotoWithController:(UIViewController *)viewController fileBlock:(WJTZImageManagerImageVideoStringBlock)fileBlock;


#pragma mark - others

/**
 获取data数据
 @param array 传入数组（UIimage，PHAsset,NSData）
 @param finish 回调Data数据
 */
+ (void)getDataWithArray:(NSArray *)array finish:(void(^)(NSArray *array))finish ;

/**保存data数据到相册*/
+ (void)savePhotoWithData:(NSData *)data;
/**保存YYImage对象，主要处理动态图到相册*/
//+ (void)savePhotoWithYYImage:(YYImage *)image;

+ (BOOL)haveGifWithAssetArray:(NSArray *)aseetArray;

/**判断data数据是不是gif*/
+ (BOOL)isGifWithImageData: (NSData *)data;

/**普通图片压缩，先压缩质量再压缩尺寸，最大字节 2*1024*1024 = 2M*/
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

/**GIF图片压缩还没有找到*/
@end
