//
//  LeftNavViewController.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "LeftSideBarViewController.h"
#import "FirstViewController.h"
#import "SideBarSelectedDelegate.h"
#import "PFRewardsViewController.h"
#import "PFGoodthingViewController.h"
#import "PFBadthingViewController.h"
#import "GoodViewController.h"
#import "BadViewController.h"

@interface LeftSideBarViewController ()
{
    NSArray *_dataList;
    int _selectIdnex;
}
@end

@implementation LeftSideBarViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:0]];
        _selectIdnex = 0;
    }
    
    UIImage *image = [UIImage imageNamed:@"daily_tracker_bg2.png"];
    _dailyBack = [[UIImageView alloc] initWithImage:image];//[image stretchableImageWithLeftCapWidth:14 topCapHeight:21]];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    _dailyBack.Frame = CGRectMake(0, 0, _dailyBack.image.size.width, 460);
   //dailyBack.center = CGPointMake(dailyBack.image.size.width/2,self.view.frame.size.height/2);
    [self.view addSubview:_dailyBack];
    
    UILabel *youLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 190, 120, 25)];
    youLabel.text = @"Your Points";
    youLabel.backgroundColor = [UIColor clearColor];
    youLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:youLabel];
    
    UILabel *themLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 132, 120, 25)];
    themLabel.text = @"Their Points";
    themLabel.backgroundColor = [UIColor clearColor];
    themLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:themLabel];
    
    UILabel *youPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 190, 100, 25)];
    youPointsLabel.text = @"400";
    youPointsLabel.backgroundColor = [UIColor clearColor];
    youPointsLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:youPointsLabel];
    
    UILabel *themPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 132, 100, 25)];
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
    themBtnimg.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +22);
    [self.view addSubview:themBtnimg];
    
    UIButton *youBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    youBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    youBtn.center = CGPointMake(youBtnimg.image.size.width/2, youBtnimg.image.size.height*3 +7);
    [youBtn setTitle:@"Your Habits" forState:UIControlStateNormal];
    [youBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    youBtn.tag = 10;
    [youBtn addTarget:self action:@selector(youBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youBtn];
    
    _themBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _themBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    _themBtn.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +22);
    [_themBtn setTitle:@"Them Habits" forState:UIControlStateNormal];
    _themBtn.tag = 20;
    [_themBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_themBtn addTarget:self action:@selector(themBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_themBtn];
    
    goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goodBtn.frame = CGRectMake(65, themBtnimg.image.size.height*6, 105, 30);
    [goodBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    goodBtn.tag = 1;
    [self.view addSubview:goodBtn];
    
    badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    badBtn.frame = CGRectMake(65, themBtnimg.image.size.height*8-5, 105, 30);
    [badBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    badBtn.tag = 2;
    [self.view addSubview:badBtn];
    
    rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rewardBtn.frame = CGRectMake(65, themBtnimg.image.size.height*10, 105, 30);
    [rewardBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rewardBtn.tag = 3;
    [self.view addSubview:rewardBtn];
}

- (void)rewardsBtnClicked:(id)sender
{
    int index = ((UIButton *)sender).tag;
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:index]];
    }
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
    UIImage *image = [UIImage imageNamed:@"daily_tracker_bg.png"];
    _dailyBack.image = image;
    goodBtn.tag = 1;
    badBtn.tag = 2;
    rewardBtn.tag = 3;
}

- (void)themBtnClicked
{
    UIImage *image = [UIImage imageNamed:@"daily_tracker_bg2.png"];
    _dailyBack.image = image;
    goodBtn.tag = 4;
    badBtn.tag = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UINavigationController *)subConWithIndex:(int)index
{
    if (index == 0) {
        FirstViewController *con = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
        con.index = index+1;
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else
        if (index == 1){
    PFGoodthingViewController *con = [[PFGoodthingViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
    nav.navigationBar.hidden = YES;
        return nav ;
    }
    else if (index == 2){
        PFBadthingViewController *con = [[PFBadthingViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else if(index == 3){
        PFRewardsViewController *con = [[PFRewardsViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else if(index == 4){
        GoodViewController *con = [[GoodViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else {
        BadViewController *con = [[BadViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }
    
}

@end
