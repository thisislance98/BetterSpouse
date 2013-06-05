//
//  LeftNavViewController.h
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideBarSelectDelegate ;

@interface LeftSideBarViewController : UIViewController
{
    UIButton *_themBtn;
    UIImageView *_dailyBack;
    UIButton *goodBtn;
    UIButton *badBtn;
    UIButton *rewardBtn;
    
}

@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;
@end

