//
//  WJTZImageManager.m
//  TZImagePickerController
//
//  Created by tqh on 2017/11/15.
//  Copyright © 2017年 谭真. All rights reserved.
//

#import "WJTZImageManager.h"

@implementation WJTZImageManager

+ (void)showImageAndVideoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock fileBlock:(WJTZImageManagerImageVideoBlock)fileBlock {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    [self pikerDefaultWithPikerController:imagePickerVc];
    imagePickerVc.allowPickingVideo = YES;
    
    //照片选择回调
    imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        if (finishBlock) {
            finishBlock(photos,assets,isSelectOriginalPhoto);
        }
    };
    //视频回调
    imagePickerVc.didFinishPickingVideoHandle = ^(UIImage *coverImage,id asset){
//        [MouoHUDManager showLoading];
        
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MouoHUDManager hideHUD];
                fileBlock(coverImage,outputPath);
            });
            
        }];
    };
    
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

+ (void)showImagePhotoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
     [self pikerDefaultWithPikerController:imagePickerVc];
    imagePickerVc.allowPickingVideo = NO;
    //照片回调
    imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        if (finishBlock) {
            finishBlock(photos,assets,isSelectOriginalPhoto);
        }
    };
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
    
}

+ (void)showVideoImagePhotoWithController:(UIViewController *)viewController fileBlock:(WJTZImageManagerImageVideoStringBlock)fileBlock {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = NO;
    [self pikerDefaultWithPikerController:imagePickerVc];
    
    //视频回调
    imagePickerVc.didFinishPickingVideoHandle = ^(UIImage *coverImage,id asset){
    
//        [MouoHUDManager showLoading];
        
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MouoHUDManager hideHUD];
                fileBlock(outputPath);
            });
            
        }];
    };
    
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

+ (void)showGifImagePhotoWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerImageBlock)finishBlock{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingMultipleVideo = YES;
    imagePickerVc.allowPickingVideo = NO;
    
    [self pikerDefaultWithPikerController:imagePickerVc];
    
    //所有类型的回调，走图片数组不是原图
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        if (finishBlock) {
            finishBlock(photos,assets,isSelectOriginalPhoto);
        }
    }];
    
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

+ (void)showGifImageIDataWithController:(UIViewController *)viewController count:(NSInteger)count finishBlock:(WJTZImageManagerDataBlock)finishBlock {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingMultipleVideo = YES;
    imagePickerVc.allowPickingVideo = NO;
    
    [self pikerDefaultWithPikerController:imagePickerVc];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
        if (finishBlock) {
            //将原图转换为data
            [self getDataWithArray:assets finish:^(NSArray *array) {
                finishBlock(array);
            }];
        }
    }];
    
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark - others

+ (void)getDataWithArray:(NSArray *)array finish:(void(^)(NSArray *array))finish {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *assetArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            [dataArray addObject:UIImageJPEGRepresentation(obj, 0.8)];
        }
        if ([obj isKindOfClass:[NSData class]]) {
            [dataArray addObject:obj];
        }
        if ([obj isKindOfClass:[PHAsset class]]) {
            [assetArray addObject:obj];
        }
        
    }];
    dispatch_group_t group = dispatch_group_create();
    [assetArray enumerateObjectsUsingBlock:^(PHAsset *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
            dispatch_group_enter(group);
        [[TZImageManager manager] getOriginalPhotoDataWithAsset:obj completion:^(NSData *data, NSDictionary *info, BOOL isDegraded) {
            
            [dataArray addObject:data];
            dispatch_group_leave(group);
        }];
      
    }];
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        
        finish(dataArray);
    });
    
}

+ (void)savePhotoWithData:(NSData *)data {
    
//    [[TZImageManager manager] savePhotoWithData:data completion:^(NSError *error) {
//        if (!error) {
//            
////            [MouoHUDManager showSuccessWithString:@"保存图片成功"];
//        }else {
////            [MouoHUDManager showErrorWithString:@"保存失败"];
//        }
//    } ];
}

//+ (void)savePhotoWithYYImage:(YYImage *)image {
//    
//    if (image.animatedImageData) {
//        [[TZImageManager manager] savePhotoWithData:image.animatedImageData completion:^(NSError *error) {
//            if (!error) {
//                [MouoHUDManager showSuccessWithString:@"保存图片成功"];
//            }else {
//                [MouoHUDManager showErrorWithString:@"保存失败"];
//            }
//        } ];
//    }else {
//        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error) {
//            if (!error) {
//                [MouoHUDManager showSuccessWithString:@"保存图片成功"];
//            }else {
//                [MouoHUDManager showErrorWithString:@"保存失败"];
//            }
//        } ];
//    }
//    
//}

+ (BOOL)haveGifWithAssetArray:(NSArray *)aseetArray {
    __block BOOL haveGif = NO;
    [aseetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[TZImageManager manager] getAssetType:obj] == TZAssetModelMediaTypePhotoGif) {
            haveGif = YES;
            *stop = YES;
        }

    }];
    return haveGif;
}

+ (void)pikerDefaultWithPikerController:(TZImagePickerController *)imagePickerVc {
//    
//    imagePickerVc.oKButtonTitleColorNormal   = [MouoColor colorWithNumber1];
//    imagePickerVc.oKButtonTitleColorDisabled = [MouoColor colorWithNumber1];
//    imagePickerVc.naviBgColor = [MouoColor colorWithNumber1];
}

+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

+ (BOOL)isGifWithImageData: (NSData *)data {
    if ([[self contentTypeWithImageData:data] isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)contentTypeWithImageData: (NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
            
            return nil;
    }
    return nil;
}


@end
