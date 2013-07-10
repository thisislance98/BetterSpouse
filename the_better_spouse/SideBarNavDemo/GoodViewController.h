//
//  GoodViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeThemLabelTextNum <NSObject>

- (void)changeSpouseTextfieldNumber:(NSString *)number;

@end

@interface GoodViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSInteger selectTask;
    int       viewNumber;
}
@property (nonatomic, strong) UIImageView *goodImage;
@property (nonatomic, strong) UIImageView *remainPoint;
@property (nonatomic, strong) UILabel     *point;
@property (nonatomic, strong) UITableView *goodTable;
@property (nonatomic, strong) id<changeThemLabelTextNum>delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number;
@end
