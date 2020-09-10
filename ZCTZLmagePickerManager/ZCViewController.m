//
//  ZCViewController.m
//  ZCTZLmagePickerManager
//
//  Created by 张闯闯 on 2020/9/9.
//  Copyright © 2020 张闯闯. All rights reserved.
//

#import "ZCViewController.h"
#import "UIViewController+ZCLImagerSeleted.h"
#import "WJTZImageManager.h"

#import <Masonry.h>
@interface ZCViewController ()
@property (strong, nonatomic) UIImageView *image_title;
@property (strong, nonatomic) NSMutableArray<PHAsset *> *selectedImg;
@end

@implementation ZCViewController


-(NSMutableArray<PHAsset *> *)selectedImg{
    if (!_selectedImg) {
        self.selectedImg = [NSMutableArray array];
    }
    return _selectedImg;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    self.image_title = [[UIImageView alloc]init];
    self.image_title.layer.cornerRadius = 30;
    self.image_title.layer.masksToBounds = YES;
    self.image_title.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.image_title];
    
    
    UIButton *seleted_img = [UIButton buttonWithType:UIButtonTypeCustom];
    [seleted_img setBackgroundColor:[UIColor redColor]];
    seleted_img.titleLabel.font = [UIFont systemFontOfSize:14];
    [seleted_img setTitle:@"点击选择单选" forState:UIControlStateNormal];
    [seleted_img addTarget:self action:@selector(seleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seleted_img];
        
    UIButton *seleted_imgs = [UIButton buttonWithType:UIButtonTypeCustom];
    [seleted_imgs setBackgroundColor:[UIColor redColor]];
    seleted_imgs.titleLabel.font = [UIFont systemFontOfSize:14];
    [seleted_imgs setTitle:@"点击选择多选" forState:UIControlStateNormal];
    [seleted_imgs addTarget:self action:@selector(seleteImagesAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seleted_imgs];
    
    
    UIButton *seleted_alert = [UIButton buttonWithType:UIButtonTypeCustom];
    [seleted_alert setBackgroundColor:[UIColor redColor]];
    seleted_alert.titleLabel.font = [UIFont systemFontOfSize:14];
    [seleted_alert setTitle:@"Alett弹窗" forState:UIControlStateNormal];
    [seleted_alert addTarget:self action:@selector(seletedAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seleted_alert];
    
    
    [self.image_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    
    [seleted_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image_title.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100,40));
    }];

    [seleted_imgs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seleted_img.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        
    }];
    [seleted_alert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seleted_imgs.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
}
 //单选
- (void)seleteImageAction:(UIButton *)senter{
    [self takePhoneIsTailoring:YES imageCropMode:RSKImageCropModeRound imageCropSize:CGSizeMake(0, 0) finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
        self.image_title.image = [images firstObject];
        
    }];
}
//多选
- (void)seleteImagesAction:(UIButton *)senter{
    [self takePhoneMultipleChoice:9 seleAsset:self.selectedImg finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
    //可以用 NSARRAY 
        [self.selectedImg  removeAllObjects];
        [self.selectedImg addObjectsFromArray:assets];
          
      } fileBlock:^(NSString * _Nonnull videoPath) {
          
     
      }];
}

//弹窗aler

-(void)seletedAlert:(UIButton *)senter{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
           
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        [self takePhoneCameraChoce:NO imageCropMode:1 finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
            self.image_title.image = [images firstObject];
            
        }];
    }];
    
    [alertVc addAction:takePhotoAction];
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoneIsTailoring:YES imageCropMode:NO imageCropSize:CGSizeMake(0, 0) finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
             self.image_title.image = [images firstObject];
        }];
    }];
    
    [alertVc addAction:imagePickerAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];

    [self presentViewController:alertVc animated:YES completion:nil];
    
}

@end
