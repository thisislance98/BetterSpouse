//
//  RewardViewController.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-21.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "RewardViewController.h"
#import "SidebarViewController.h"
#import "LeftSideBarViewController.h"

@interface RewardViewController ()
@property (nonatomic, strong) NSMutableArray *rewardDataArray;
@property (nonatomic, strong) NSMutableArray *rewardNumberArray;
@end

@implementation RewardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        viewNumber = number;
        if (number == 3) {
            _rewardDataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@reward",[PFUser currentUser]]]];
            _rewardNumberArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@rewardnum",[PFUser currentUser]]]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	UIImageView *rewardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rewards.png"]];
    rewardImage.Frame = (CGRect){CGPointZero, rewardImage.image.size};
    rewardImage.center = CGPointMake(rewardImage.image.size.width + 40 , rewardImage.image.size.height/1.4);
    [self.view addSubview:rewardImage];
    
    _rewardsTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, rewardImage.frame.size.height+26, 320, self.view.frame.size.height -rewardImage.frame.size.height) style:UITableViewStylePlain];
    _rewardsTable.backgroundColor = [UIColor clearColor];
    _rewardsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rewardsTable.delegate = self;
    _rewardsTable.dataSource = self;
    [self.view addSubview:_rewardsTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.Frame = (CGRect){CGPointZero, rewardImage.image.size};
    dailyBtn.center = CGPointMake(rewardImage.image.size.width + 40 , rewardImage.image.size.height/1.4);
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rewardDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"reward_item1.png"];
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 180.0f, 38.0f)];
    rewardLabel.backgroundColor = [UIColor clearColor];
    rewardLabel.textAlignment = UITextAlignmentCenter;
    rewardLabel.text = [_rewardDataArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:rewardLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(272.0f, 11.0f, 38.0f, 40.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = [_rewardNumberArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:label];
    
    if (viewNumber != 3) {
        cell.selectionStyle = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (viewNumber == 6) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Are you sure you will buy this reward?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"NO", nil];
        [alert show];
        selectRow = indexPath.row;
    }else{
        UITableViewCell *cell = [_rewardsTable cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [PFPush sendPushDataToChannel:@"Gaint" withData:[NSDictionary dictionaryWithObjectsAndKeys:@"Your spouse buy the reward",@"notification" ,nil] error:nil];
        lastNumber = [_rewardNumberArray objectAtIndex:selectRow];
    }
}

- (void)dailyBtnClicked
{
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
    {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
