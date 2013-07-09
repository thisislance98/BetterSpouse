//
//  AppDelegate.h
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class SidebarViewController;

@protocol notificationDelegate <NSObject>

- (void)changeYouTextfieldNumber:(NSString *)number;
- (void)changeThemTextfieldNumber:(NSString *)number;
- (void)changeGoodTextfieldNumber:(NSString *)number;
- (void)changeBadTextfieldNumber:(NSString *)number;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (assign, nonatomic) id<notificationDelegate>delegate;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SidebarViewController *viewController;

@end
