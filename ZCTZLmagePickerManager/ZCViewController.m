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

@end

@implementation ZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
        
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
    
    
    
    
    
    [seleted_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100,40));
    }];

    [seleted_imgs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seleted_img.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        
    }];
    
    
    
}


   
- (void)seleteImageAction:(UIButton *)senter{
    [self takePhoneIsTailoring:YES imageCropMode:RSKImageCropModeRound imageCropSize:CGSizeMake(0, 0) finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
}
- (void)seleteImagesAction:(UIButton *)senter{
    [self takePhoneMultipleChoice:9 seleAsset:self.selectAssets finishBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray * _Nonnull assets, BOOL isSelectOriginalPhoto) {
          [self.selectAssets addObjectsFromArray:assets];
          
      } fileBlock:^(NSString * _Nonnull videoPath) {
          
      }];
}

@end
