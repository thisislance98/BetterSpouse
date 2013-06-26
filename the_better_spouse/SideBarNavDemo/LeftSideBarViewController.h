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
    UILabel *themPointsLabel;
    UIImageView *winView;
}

@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
@property (nonatomic, strong) UILabel *youPointsLabel;
@end

