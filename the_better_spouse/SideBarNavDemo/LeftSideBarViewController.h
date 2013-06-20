//
//  LeftNavViewController.h
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointsModel.h"
@protocol SideBarSelectDelegate ;

@interface LeftSideBarViewController : UIViewController
{
    UIButton *_themBtn;
    UIImageView *_dailyBack;
    UIButton *goodBtn;
    UIButton *badBtn;
    UIButton *rewardBtn;
    PointsModel *model;
}

@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
@end

