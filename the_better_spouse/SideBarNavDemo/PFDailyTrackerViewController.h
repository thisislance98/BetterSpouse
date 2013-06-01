//
//  PFDailyTrackerViewController.h
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SideBarSelectDelegate ;
@interface PFDailyTrackerViewController : UIViewController{
    UIButton *_themBtn;
}
@property (assign,nonatomic)id<SideBarSelectDelegate>delegate;

@end
