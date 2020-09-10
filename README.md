# ZCTZLmagePickerManager
## 基于TZImagePickerController二次封装 预留出方法

图片
![图片](https://github.com/zhangchuangchuang/Review_IMG/blob/master/1599737271672.jpg)

*包含 单选 多选相册 视频 预留 勾选gif  多选视频 *  
*项目中包含基于NSObject的 ZCTZImageManager文件 还有category的 UIViewController+ZCLImagerSeleted 文件*

*俩个文件的方法功能 都一样 可以更加项目需要 调用*


*第一*
```
/**
 单选
 @param isTailoring     是否裁剪
 @param imageCropMode 裁剪类型
 @param imageCropSize 自定义裁剪size
 @param finishBlock  选中图片回调
 */

-(void)takePhoneIsTailoring:(BOOL)isTailoring imageCropMode:(ZCKImageCropMode)imageCropMode imageCropSize:(CGSize)imageCropSize finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock;
```
```
/**
 多选图片 单选视频
 @param count 最大可选数量
 @param selectedAsset  多选图片下 选中状态回显
 @param finishBlock  选中图片回调
 @param fileBlock  选中视频回调
 */
-(void)takePhoneMultipleChoice:(NSInteger)count seleAsset:(NSMutableArray *)selectedAsset finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock fileBlock:(LocationVideoSelectedCompletBlock)fileBlock;
```

```
/**
 选中相机
 @param isTailoring 是否裁剪
 @param imageCropMode  裁剪的类型
 @param finishBlock 图片回调
 */
- (void)takePhoneCameraChoce:(BOOL)isTailoring imageCropMode:(ZCKImageCropMode)imageCropMode finishBlock:(LocationPhotoSelectedCompleteBlock)finishBlock;
```
