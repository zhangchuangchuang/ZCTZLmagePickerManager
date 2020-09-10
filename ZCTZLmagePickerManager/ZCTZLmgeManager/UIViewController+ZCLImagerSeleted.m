//
//  UIViewController+ZCLImagerSeleted.m
//  ZCTZLmagePickerManager
//
//  Created by 张闯闯 on 2020/9/8.
//  Copyright © 2020 张闯闯. All rights reserved.
//

#import "UIViewController+ZCLImagerSeleted.h"

@interface UIViewController()
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, assign) BOOL is_Tailoring;//单选默认是允许裁剪
@property (nonatomic, assign) BOOL is_video;//是否选择视频
@property (nonatomic, assign) BOOL is_phone;//是否选择照片
@property (nonatomic, assign) BOOL is_gif;//是否选择GIF
@property (nonatomic, assign) BOOL is_rount;//使用原型裁剪框
@property (nonatomic, assign) BOOL is_multiple;//是否允许多选视频
@property (nonatomic, assign) BOOL is_TakeVideo;//是否允许拍视频
@property (nonatomic, assign) BOOL is_originalPhoto;//是否显示原图

@property (nonatomic, assign) ZCKImageCropMode imgCropMode;
@property (nonatomic, assign) NSInteger phone_count;//照片最大可选数量

//@property (nonatomic, assign) BOOL is_TimeAsc;//是否按修改时间升序排列  默认开启
//@property (nonatomic, assign) BOOL is_Pictures;//是否显示内部拍照按钮 默认关闭
//@property (nonatomic, assign) NSInteger line_count;//每行展示照片张数 默认是四 如有需要可以打开注释 自行修改


@end
@implementation UIViewController (ZCLImagerSeleted)

#pragma mark -- category 不能直接添加成员变量，但是可以通过runtime的方式间接实现添加成员变量的效果。


//MARK: -单选默认是允许裁剪
-(void)setIs_Tailoring:(BOOL)is_Tailoring{
    objc_setAssociatedObject(self, @selector(is_Tailoring), @(is_Tailoring), OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)is_Tailoring{
    return [objc_getAssociatedObject(self, @selector(is_Tailoring)) boolValue];
}

//MARK: -是否选择视频
- (void)setIs_video:(BOOL)is_video{
    objc_setAssociatedObject(self, @selector(is_video), @(is_video), OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)is_video{
    return [objc_getAssociatedObject(self, @selector(is_video)) boolValue];
}

//MARK: -是否选择照片
- (void)setIs_phone:(BOOL)is_phone{
    objc_setAssociatedObject(self, @selector(is_phone), @(is_phone), OBJC_ASSOCIATION_RETAIN);
}
-(BOOL)is_phone{
    return [objc_getAssociatedObject(self, @selector(is_phone)) boolValue];
}


- (void)setIs_gif:(BOOL)is_gif{
    objc_setAssociatedObject(self, @selector(is_gif), @(is_gif), OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)is_gif{
   return [objc_getAssociatedObject(self, @selector(is_gif)) boolValue];
}

-(void)setIs_rount:(BOOL)is_rount{
    objc_setAssociatedObject(self, @selector(is_rount), @(is_rount), OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)is_rount{
    return [objc_getAssociatedObject(self, @selector(is_rount)) boolValue];
}

- (void)setIs_multiple:(BOOL)is_multiple{
    objc_setAssociatedObject(self, @selector(is_multiple), @(is_multiple), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)is_multiple{
    return [objc_getAssociatedObject(self, @selector(is_multiple)) boolValue];
}

- (void)setIs_TakeVideo:(BOOL)is_TakeVideo{
    objc_setAssociatedObject(self, @selector(is_TakeVideo), @(is_TakeVideo), OBJC_ASSOCIATION_RETAIN);
}
- (BOOL)is_TakeVideo{
    return [objc_getAssociatedObject(self, @selector(is_TakeVideo)) boolValue];
}

- (void)setIs_originalPhoto:(BOOL)is_originalPhoto{
    objc_setAssociatedObject(self, @selector(is_originalPhoto), @(is_originalPhoto), OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)is_originalPhoto{
    return [objc_getAssociatedObject(self, @selector(is_originalPhoto)) boolValue];
}

-(void)setImgCropMode:(ZCKImageCropMode)imgCropMode{
    objc_setAssociatedObject(self, @selector(imgCropMode), @(imgCropMode), OBJC_ASSOCIATION_RETAIN);
}


-(void)setPhone_count:(NSInteger)phone_count{
    objc_setAssociatedObject(self, @selector(phone_count), @(phone_count), OBJC_ASSOCIATION_RETAIN);
}
-(NSInteger)phone_count{
    return [objc_getAssociatedObject(self, @selector(phone_count))intValue];
}
-(ZCKImageCropMode)imgCropMode{
    return [objc_getAssociatedObject(self, @selector(imgCropMode))intValue];
}

- (void)setSelectAssets:(NSMutableArray<PHAsset *> *)selectAssets{
    objc_setAssociatedObject(self, @selector(selectAssets), selectAssets, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<PHAsset *> *)selectAssets{
    return objc_getAssociatedObject(self, @selector(selectAssets));
}

-(void)setLocationPhotoSelectedCompleteBlock:(LocationPhotoSelectedCompleteBlock)locationPhotoSelectedCompleteBlock{
    objc_setAssociatedObject(self, @selector(locationPhotoSelectedCompleteBlock), locationPhotoSelectedCompleteBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(LocationPhotoSelectedCompleteBlock)locationPhotoSelectedCompleteBlock{
    return  objc_getAssociatedObject(self, @selector(locationPhotoSelectedCompleteBlock));
}

- (void)setLocationVideoSelectedCompletBlock:(LocationVideoSelectedCompletBlock)locationVideoSelectedCompletBlock{
    objc_setAssociatedObject(self, @selector(locationVideoSelectedCompletBlock), locationVideoSelectedCompletBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LocationVideoSelectedCompletBlock)locationVideoSelectedCompletBlock{
    return objc_getAssociatedObject(self, @selector(locationVideoSelectedCompletBlock));
}




//MARK: -单选图片  裁剪  裁剪类型
-(void)takePhoneIsTailoring:(BOOL)isTailoring imageCropMode:(ZCKImageCropMode)imageCropMode imageCropSize:(CGSize)imageCropSize finishBlock:(nonnull LocationPhotoSelectedCompleteBlock)finishBlock{

    self.phone_count = 1;
    self.is_Tailoring = isTailoring;
    self.is_TakeVideo = NO;
    self.is_video = NO;
    self.is_phone = YES;
    self.is_gif = NO;
    self.imgCropMode = imageCropMode;
    if (self.is_Tailoring) {//如果显示裁剪 原图状态不能打开
        self.is_originalPhoto = NO;
    }
    
    if (finishBlock) {
        self.locationPhotoSelectedCompleteBlock = finishBlock;
    }
    
    [self pushImagePhonePicker];
}

-(void)takePhoneMultipleChoice:(NSInteger)count seleAsset:(NSMutableArray *)selectedAsset finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock fileBlock:(LocationVideoSelectedCompletBlock)fileBlock{
    
    self.phone_count = count;
    self.is_video = YES;
    self.is_phone = YES;
    self.is_gif = NO;
    self.is_Tailoring = NO;
    if (finishBlock) {
        self.locationPhotoSelectedCompleteBlock = finishBlock;
    }
    if (fileBlock) {
        self.locationVideoSelectedCompletBlock = fileBlock;
    }
    
    [self pushImagePhonePicker];
}



- (void)pushImagePhonePicker{
 
    if (self.phone_count <= 0) {
        return;
    }
    
    //初始化 TZImagePickerController  MaxImagerCount 相片最大可选数量  columnNumber 相册选择器中 一行显示cell的数量
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:self.phone_count columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.isSelectOriginalPhoto = self.is_originalPhoto;//是否显示原图
    if(self.phone_count>1){
        NSLog(@"====%@",self.selectAssets);
        imagePickerVc.selectedAssets = self.selectAssets;//如果多选图片 回显选中状态
    }
    
    imagePickerVc.allowTakePicture = NO;//是否允许显示拍照按钮  本次已关闭 如果有需要可自行赋值
    imagePickerVc.allowTakeVideo = self.is_TakeVideo;//同上
    
    imagePickerVc.videoMaximumDuration = 10;//视频的最大拍摄时间
    //拍摄视频质量
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    imagePickerVc.autoSelectCurrentWhenDone = NO;// 如果用户未选择任何图片，在点击完成按钮时自动选中当前图片，默认YES
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;//如果超过最大选择图片数据  其他照片会显示 模糊图层
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    //是否可以多种类选择  此处 全部设置成NO  可以根据需要 动态设置
    imagePickerVc.allowPickingVideo = self.is_video;//是否允许选择视频
    imagePickerVc.allowPickingImage = self.is_phone;//是否允许选择图片
    imagePickerVc.allowPickingOriginalPhoto = NO;//默认为YES，如果设置为NO,原图按钮将隐藏，用户不能选择发送原图
    imagePickerVc.allowPickingGif = self.is_gif;//单选是否允许选择gif
    
//    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
//    imagePickerVc.sortAscendingByModificationDate = YES;//照片排列按修改时间升序 默认YES

    
    imagePickerVc.allowCrop = self.is_Tailoring;
    if (self.is_Tailoring) { //是否允许裁剪
        imagePickerVc.showSelectBtn = NO;//是否显示 选中状态图标  多选情况下不能设置为NO
        
        if (self.imgCropMode == 0) {
            imagePickerVc.needCircleCrop = YES;
        }else if (self.imgCropMode == 1){
            NSInteger left = 30;
            NSInteger widthHeight = self.view.tz_width - 2 * left;
            NSInteger top = (self.view.tz_height - widthHeight) / 2;
            imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
            imagePickerVc.scaleAspectFillCrop = YES;
        }else if (self.imgCropMode == 2){
            
            
        }
    }
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (self.locationPhotoSelectedCompleteBlock) {
            self.locationPhotoSelectedCompleteBlock(photos, assets, isSelectOriginalPhoto);
        }
      
    }];
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetLowQuality success:^(NSString *outputPath) {
            // NSData *data = [NSData dataWithContentsOfFile:outputPath];
            NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.locationVideoSelectedCompletBlock) {
                    self.locationVideoSelectedCompletBlock(outputPath);
                }
            });
            
            // Export completed, send video here, send by outputPath or NSData
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
        } failure:^(NSString *errorMessage, NSError *error) {
            NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
        }];
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
//    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (self.showTakeVideoBtnSwitch.isOn) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (self.showTakePhotoBtnSwitch.isOn) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}


#pragma mark -TZImagePickerControllerDelegate-
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {}
@end
