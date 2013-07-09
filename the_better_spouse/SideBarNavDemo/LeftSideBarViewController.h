//
//  LeftNavViewController.h
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointsModel.h"
#import "AppDelegate.h"
#import "GoodViewController.h"
#import "BadViewController.h"

@protocol SideBarSelectDelegate;

@interface LeftSideBarViewController : UIViewController<notificationDelegate>
{
    UIButton *_themBtn;
    UIImageView *_dailyBack;
    UIButton *goodBtn;
    UIButton *badBtn;
    UIButton *rewardBtn;
    PointsModel *model;
    UIImageView *winView;
}

@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
@property (nonatomic, strong) UILabel *youPointsLabel;
@property (nonatomic, strong) UILabel *themPointsLabel;
@end

