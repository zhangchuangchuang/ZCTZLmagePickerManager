//
//  UIViewController+ZCLImagerSeleted.h
//  ZCTZLmagePickerManager
//
//  Created by 张闯闯 on 2020/9/8.
//  Copyright © 2020 张闯闯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <TZImagePickerController.h>
#import <Photos/Photos.h>
#import <objc/message.h>
#import <UIView+Layout.h>
NS_ASSUME_NONNULL_BEGIN

//通过相机block
typedef void(^LocationCameraCompleteBlock)(UIImage *image);
//多选图片
typedef void (^LocationPhotoSelectedCompleteBlock)(NSArray<UIImage *> *images,NSArray *assets,BOOL isSelectOriginalPhoto);
//单选视频
typedef void (^LocationVideoSelectedCompletBlock)(NSString *videoPath);
//多选视频
//typedef void (^LocationViewSelectedMultipleViewBlcok)(NSString *videoPath);
//选择gif


//裁剪类型枚举
typedef enum: NSInteger{
    RSKImageCropModeRound = 0,//圆形
    RSKImageCropModeSquare,//正方形
    RSKImageCropModeCustomize,//自定义视图
}ZCKImageCropMode;


@interface UIViewController (ZCLImagerSeleted)<UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate>


//系统获取图片block回调
@property (nonatomic, copy) LocationPhotoSelectedCompleteBlock locationPhotoSelectedCompleteBlock;

@property (nonatomic,copy) LocationVideoSelectedCompletBlock locationVideoSelectedCompletBlock;

@property (nonatomic, strong) NSMutableArray<PHAsset*> *selectAssets; //多选图片 选择转态回显
/**
 单选
 @param isTailoring     是否裁剪
 @param imageCropMode 裁剪类型
 @param imageCropSize 自定义裁剪size
 @param finishBlock  选中图片回调
 */

-(void)takePhoneIsTailoring:(BOOL)isTailoring imageCropMode:(ZCKImageCropMode)imageCropMode imageCropSize:(CGSize)imageCropSize finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock;

/**
 多选图片 单选视频
 @param count 最大可选数量
 @param selectedAsset  多选图片下 选中状态回显
 @param finishBlock  选中图片回调
 @param fileBlock  选中视频回调
 */
-(void)takePhoneMultipleChoice:(NSInteger)count seleAsset:(NSMutableArray *)selectedAsset finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock fileBlock:(LocationVideoSelectedCompletBlock)fileBlock;
/**
 选中相机
 
 */



@end

NS_ASSUME_NONNULL_END
