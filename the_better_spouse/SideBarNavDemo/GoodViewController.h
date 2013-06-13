//
//  GoodViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSInteger selectTask;
}
@property (nonatomic, strong) UIImageView *goodImage;
@property (nonatomic, strong) UIImageView *remainPoint;
@property (nonatomic, strong) UILabel     *point;
@property (nonatomic, strong) UITableView *goodthingTable;
@end
