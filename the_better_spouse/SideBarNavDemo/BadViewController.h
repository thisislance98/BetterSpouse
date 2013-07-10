//
//  BadViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeYouLabelTextNum <NSObject>

- (void)changeTextfieldNumber:(NSString *)number;

@end

@interface BadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSInteger selectTask;
    int       viewNumber;
}
@property (nonatomic, strong) UIImageView *badimage;
@property (nonatomic, strong) UIImageView *remain;
@property (nonatomic, strong) UILabel     *points;
@property (nonatomic, strong) UITableView *badThingTable;
@property (nonatomic, strong) id<changeYouLabelTextNum>delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number;
@end
