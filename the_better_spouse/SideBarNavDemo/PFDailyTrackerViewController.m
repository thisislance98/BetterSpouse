//
//  PFDailyTrackerViewController.m
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFDailyTrackerViewController.h"
#import "PFRewardsViewController.h"
#import "PFGoodthingViewController.h"
#import "PFBadthingViewController.h"
#import "SidebarViewController.h"

@interface PFDailyTrackerViewController ()

@end

@implementation PFDailyTrackerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [_delegate leftSideBarSelectWithController:[self subConWithIndex]];
    }

    UIImage *image = [UIImage imageNamed:@"daily_tracker_bg.png"];
    UIImageView *dailyBack = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
    dailyBack.Frame = (CGRect){CGPointZero, dailyBack.image.size.width,self.view.frame.size.height};
    [self.view addSubview:dailyBack];
    
    UILabel *youLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 102, 120, 25)];
    youLabel.text = @"Your Points";
    youLabel.backgroundColor = [UIColor clearColor];
    youLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:youLabel];
    
    UILabel *themLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 44, 120, 25)];
    themLabel.text = @"Their Points";
    themLabel.backgroundColor = [UIColor clearColor];
    themLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:themLabel];
    
    UILabel *youPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 102, 100, 25)];
    youPointsLabel.text = @"400";
    youPointsLabel.backgroundColor = [UIColor clearColor];
    youPointsLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:youPointsLabel];
    
    UILabel *themPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 44, 100, 25)];
    themPointsLabel.text = @"625";
    themPointsLabel.backgroundColor = [UIColor clearColor];
    themPointsLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:themPointsLabel];
    
    UIImageView *youBtnimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_btn0.png"]];
    youBtnimg.frame = (CGRect){CGPointZero, youBtnimg.image.size};
    youBtnimg.center = CGPointMake( youBtnimg.image.size.width/2, youBtnimg.image.size.height*3 + 7);
    [self.view addSubview:youBtnimg];
    
    UIImageView *themBtnimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_btn1.png"]];
    themBtnimg.frame = (CGRect){CGPointZero, themBtnimg.image.size};
    themBtnimg.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +16);
    [self.view addSubview:themBtnimg];
    
    UIButton *youBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    youBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    youBtn.center = CGPointMake(youBtnimg.image.size.width/2, youBtnimg.image.size.height*3 +7);
    [youBtn setTitle:@"You" forState:UIControlStateNormal];
    [youBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [youBtn addTarget:self action:@selector(youBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youBtn];
    
    _themBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _themBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    _themBtn.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +16);
    [_themBtn setTitle:@"Them" forState:UIControlStateNormal];
    [_themBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_themBtn addTarget:self action:@selector(themBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_themBtn];

    UIButton *goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goodBtn.frame = CGRectMake(65, themBtnimg.image.size.height*6-8, 105, 30);
    [goodBtn addTarget:self action:@selector(goodBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goodBtn];
    
    UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    badBtn.frame = CGRectMake(65, themBtnimg.image.size.height*8-5, 105, 30);
    [badBtn addTarget:self action:@selector(badBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:badBtn];
    
    UIButton *rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rewardBtn.frame = CGRectMake(65, themBtnimg.image.size.height*10, 105, 30);
    [rewardBtn addTarget:self action:@selector(rewardsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rewardBtn];
}

- (void)rewardsBtnClicked
{
    if ([_delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
            [_delegate leftSideBarSelectWithController:[self subConWithIndex]];
        }
 }

- (UINavigationController *)subConWithIndex
{
    PFRewardsViewController *con = [[PFRewardsViewController alloc] initWithNibName:@"PFRewardsViewController" bundle:nil];
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
    nav.navigationBar.hidden = YES;
    return nav ;
}

- (void)goodBtnClicked
{
    PFGoodthingViewController *goodView = [[PFGoodthingViewController alloc] init];
    [self.navigationController pushViewController:goodView animated:YES];
}

- (void)badBtnClicked
{
    PFBadthingViewController *badView = [[PFBadthingViewController alloc] init];
    [self.navigationController pushViewController:badView animated:YES];
}

- (void)youBtnClicked
{
    NSLog(@"here");
}


- (void)themBtnClicked
{
    NSLog(@"here");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
