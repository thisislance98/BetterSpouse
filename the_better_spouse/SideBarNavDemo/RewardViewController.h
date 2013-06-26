//
//  RewardViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-21.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView     *_rewardsTable;
    NSInteger       cellNumber;
    NSInteger       selectRow;
    NSString       *lastNumber;
    int       viewNumber;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number;

@end
