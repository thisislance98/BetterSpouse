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
#import "RewardViewController.h"
#import "AppDelegate.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

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
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]])
        {
            NSString *spouseString = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
            PFQuery *query = [PFQuery queryWithClassName:@"player"];
            [query whereKey:@"userid" equalTo:spouseString];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                if(!error){
                    if (objects.count != 0) {
                        NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"player"];
                        PFObject *ps = dic[@"player"];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"task"] forKey:[NSString stringWithFormat:@"%@task",spouseString]];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"score"] forKey:[NSString stringWithFormat:@"%@score",spouseString]];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badtask"] forKey:[NSString stringWithFormat:@"%@badtask",spouseString]];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badscore"] forKey:[NSString stringWithFormat:@"%@badscore",spouseString]];
                    }
                }
            }];
            PFQuery *rewQuery = [PFQuery queryWithClassName:@"rewards"];
            [rewQuery whereKey:@"userid" equalTo:spouseString];
            [rewQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                if(!error){
                    if (objects.count != 0) {
                        NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"rewards"];
                        PFObject *ps = dic[@"rewards"];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"rewards"] forKey:[NSString stringWithFormat:@"%@reward",[PFUser currentUser]]];
                        [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"rewardsNum"] forKey:[NSString stringWithFormat:@"%@rewardNum",[PFUser currentUser]]];
                    }
                }
            }];
        }
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
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app setDelegate:self];
    
    //    GoodViewController *good = [[GoodViewController alloc] init];
    //    [good setDelegate:self];
    //
    //    BadViewController *bad = [[BadViewController alloc] init];
    //    [bad setDelegate:self];
    
    UIImage *image = [UIImage imageNamed:@"daily_tracker_bg2.png"];
    _dailyBack = [[UIImageView alloc] initWithImage:image];//[image stretchableImageWithLeftCapWidth:14 topCapHeight:21]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    _dailyBack.Frame = CGRectMake(0, 0, _dailyBack.image.size.width, self.view.frame.size.height-(iPhone5?0:88));
    //dailyBack.center = CGPointMake(dailyBack.image.size.width/2,self.view.frame.size.height/2);
    [self.view addSubview:_dailyBack];
    
    UILabel *youLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 101-(iPhone5?17:88), 120, 25)];
    youLabel.text = @"Your Points";
    youLabel.backgroundColor = [UIColor clearColor];
    youLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:youLabel];
    
    UILabel *themLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height - 43-(iPhone5?7:88), 120, 25)];
    themLabel.text = @"Their Points";
    themLabel.backgroundColor = [UIColor clearColor];
    themLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:themLabel];
    
    _youPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 101-(iPhone5?17:88), 100, 25)];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@youpoint",[PFUser currentUser]]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@youpoint",[PFUser currentUser]]];
        _youPointsLabel.text = @"0";
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]];
    }else{
        _youPointsLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]];
    }
    _youPointsLabel.backgroundColor = [UIColor clearColor];
    _youPointsLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_youPointsLabel];
    
    _themPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height - 43-(iPhone5?7:88), 100, 25)];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@thempoint2",[PFUser currentUser]]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@thempoint",[PFUser currentUser]]];
        _themPointsLabel.text = @"2";
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]];
    }else{
        _themPointsLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]];
    }    _themPointsLabel.backgroundColor = [UIColor clearColor];
    _themPointsLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:_themPointsLabel];
    
    UIImageView *youBtnimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_btn0.png"]];
    youBtnimg.frame = (CGRect){CGPointZero, youBtnimg.image.size};
    youBtnimg.center = CGPointMake( youBtnimg.image.size.width/2, youBtnimg.image.size.height*3 + 7+(iPhone5?25:0));
    [self.view addSubview:youBtnimg];
    
    UIImageView *themBtnimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_btn1.png"]];
    themBtnimg.frame = (CGRect){CGPointZero, themBtnimg.image.size};
    themBtnimg.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +22+(iPhone5?25:0));
    [self.view addSubview:themBtnimg];
    
    UIButton *youBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    youBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    youBtn.center = CGPointMake(youBtnimg.image.size.width/2, youBtnimg.image.size.height*3 +7+(iPhone5?25:0));
    [youBtn setTitle:@"Your Habits" forState:UIControlStateNormal];
    [youBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    youBtn.tag = 10;
    [youBtn addTarget:self action:@selector(youBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youBtn];
    
    _themBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _themBtn.frame = CGRectMake(0, 0, youBtnimg.frame.size.width,youBtnimg.frame.size.height);
    _themBtn.center = CGPointMake(themBtnimg.image.size.width/2, themBtnimg.image.size.height*4 +22+(iPhone5?25:0));
    [_themBtn setTitle:@"Them Habits" forState:UIControlStateNormal];
    _themBtn.tag = 20;
    [_themBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_themBtn addTarget:self action:@selector(themBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_themBtn];
    
    goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goodBtn.frame = CGRectMake(65, themBtnimg.image.size.height*6+(iPhone5?34:0), 105, 30);
    [goodBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    goodBtn.tag = 1;
    [self.view addSubview:goodBtn];
    
    badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    badBtn.frame = CGRectMake(65, themBtnimg.image.size.height*8-5+(iPhone5?45:0), 105, 30);
    [badBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    badBtn.tag = 2;
    [self.view addSubview:badBtn];
    
    rewardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rewardBtn.frame = CGRectMake(65, themBtnimg.image.size.height*10+(iPhone5?60:0), 105, 30);
    [rewardBtn addTarget:self action:@selector(rewardsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rewardBtn.tag = 3;
    [self.view addSubview:rewardBtn];
    
    
    
    winView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"winning.png"]];
    [winView setFrame:CGRectMake(17, self.view.frame.size.height - 98- 43-(iPhone5?20:88), winView.image.size.width, 43)];
    [self.view addSubview:winView];
    [self showWinner];
}

- (void)changeYouTextfieldNumber:(NSString *)number{
    int  tempNum = [number intValue];
    NSLog(@"tempNum = %d",tempNum);
    int  nativeNum =[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]] intValue];
    _youPointsLabel.text = [NSString stringWithFormat:@"%d",nativeNum+tempNum];
    [[NSUserDefaults standardUserDefaults] setObject:_youPointsLabel.text forKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]];
    [self showWinner];
}

- (void)changeThemTextfieldNumber:(NSString *)number
{
    int  tempNum = [number intValue];
    NSLog(@"tempNum = %d",tempNum);
    int  nativeNum =[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]] intValue];
    _youPointsLabel.text = [NSString stringWithFormat:@"%d",nativeNum-tempNum];
    [[NSUserDefaults standardUserDefaults] setObject:_youPointsLabel.text forKey:[NSString stringWithFormat:@"%@youremainpoint",[PFUser currentUser]]];
    [self showWinner];
}

- (void)changeSpouseTextfieldNumber:(NSString *)number
{
    int  tempNum = [number intValue];
    NSLog(@"tempNum = %d",tempNum);
    int  nativeNum =[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]] intValue];
    _themPointsLabel.text = [NSString stringWithFormat:@"%d",nativeNum+tempNum];
    [[NSUserDefaults standardUserDefaults] setObject:_themPointsLabel.text forKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]];
    [self showWinner];
}

- (void)changeTextfieldNumber:(NSString *)number
{
    int  tempNum = [number intValue];
    NSLog(@"tempNum = %d",tempNum);
    int  nativeNum =[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]] intValue];
    _themPointsLabel.text = [NSString stringWithFormat:@"%d",nativeNum-tempNum];
    [[NSUserDefaults standardUserDefaults] setObject:_themPointsLabel.text forKey:[NSString stringWithFormat:@"%@dayremainpoint",[PFUser currentUser]]];
    [self showWinner];
}
- (void)rewardsBtnClicked:(id)sender
{
    int index = ((UIButton *)sender).tag;
    if ([delegate respondsToSelector:@selector(leftSideBarSelectWithController:)]) {
        [delegate leftSideBarSelectWithController:[self subConWithIndex:index]];
    }
}

- (void)showWinner
{
    NSLog(@"-----:%f",self.view.frame.size.height);
    if ([_youPointsLabel.text intValue] >= [_themPointsLabel.text intValue])
    {
        [winView setFrame:CGRectMake(17, self.view.frame.size.height - 98- 43-(iPhone5?20:88), winView.image.size.width, 43)];
    }
    else if([_youPointsLabel.text intValue] < [_themPointsLabel.text intValue])
    {
        [winView setFrame:CGRectMake(17, self.view.frame.size.height -41 - 43-(iPhone5?8:88), winView.image.size.width, 43)];
    }
}
//- (void)goodBtnClicked
//{
//    PFGoodthingViewController *goodView = [[PFGoodthingViewController alloc] init];
//    [self.navigationController pushViewController:goodView animated:YES];
//}
//
//- (void)badBtnClicked
//{
//    PFBadthingViewController *badView = [[PFBadthingViewController alloc] init];
//    [self.navigationController pushViewController:badView animated:YES];
//}

- (void)youBtnClicked
{
    goodBtn.tag = 1;
    badBtn.tag = 2;
    rewardBtn.tag = 3;
}

- (void)themBtnClicked
{
    goodBtn.tag = 4;
    badBtn.tag = 5;
    rewardBtn.tag = 6;
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
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }
    else if (index == 1){
        GoodViewController *con = [[GoodViewController alloc] initWithNibName:nil bundle:nil viewNumber:index];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }
    else if (index == 2){
        BadViewController *con = [[BadViewController alloc] initWithNibName:nil bundle:nil viewNumber:index];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else if(index == 3){
        PFRewardsViewController *con = [[PFRewardsViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else if(index == 4){
        GoodViewController *con = [[GoodViewController alloc] initWithNibName:nil bundle:nil viewNumber:index];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }else if (index == 5){
        BadViewController *con = [[BadViewController alloc] initWithNibName:nil bundle:nil viewNumber:index];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav;
    }else{
        RewardViewController *con = [[RewardViewController alloc] initWithNibName:nil bundle:nil viewNumber:index];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:con];
        nav.navigationBar.hidden = YES;
        return nav ;
    }
}

@end
