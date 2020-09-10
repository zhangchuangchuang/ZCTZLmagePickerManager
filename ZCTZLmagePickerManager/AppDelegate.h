//
//  AppDelegate.h
//  ZCTZLmagePickerManager
//
//  Created by 张闯闯 on 2020/9/8.
//  Copyright © 2020 张闯闯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;
- (void)saveContext;


@end

