//
//  BadViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSInteger selectTask;
}
@property (nonatomic, strong) UIImageView *badimage;
@property (nonatomic, strong) UIImageView *remain;
@property (nonatomic, strong) UILabel     *points;
@property (nonatomic, strong) UITableView *badThingTable;
@end
