//
//  GoodViewController.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "GoodViewController.h"
#import "SidebarViewController.h"
#import "PointsModel.h"

@interface GoodViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *numberSourceArray;
@property (nonatomic, strong) PointsModel *goodModel;

@end

@implementation GoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        viewNumber = number;
        if (number == 1) {
            _dataSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]]];
            _numberSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]]];
        }else{
            NSString *spouse = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
            _dataSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",spouse]]];
            _numberSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",spouse]]];
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	_goodImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_habits.png"]];
    _goodImage.Frame = (CGRect){CGPointZero, _goodImage.image.size};
    _goodImage.center = CGPointMake(_goodImage.image.size.width + 40 , _goodImage.image.size.height/1.4);
    [self.view addSubview:_goodImage];
    
    _remainPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remainPoint.frame = (CGRect){CGPointZero,_remainPoint.image.size};
    _remainPoint.center = CGPointMake(_remainPoint.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remainPoint];
    
    _point = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _point.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
    _point.backgroundColor = [UIColor clearColor];
    _point.textAlignment = UITextAlignmentCenter;
    [_remainPoint addSubview:_point];
    
    _goodTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _goodImage.frame.size.height+26, 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoint.frame.size.height-32) style:UITableViewStylePlain];
    _goodTable.backgroundColor = [UIColor clearColor];
    _goodTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodTable.delegate = self;
    _goodTable.dataSource = self;
    [self.view addSubview:_goodTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dailyBtn.frame = (CGRect){CGPointZero,_remainPoint.image.size.width/3,_remainPoint.image.size.height/1.5};
    dailyBtn.center = CGPointMake(_remainPoint.image.size.width/2+10, self.view.frame.size.height-23);
    [dailyBtn setTitle:@"daily" forState:UIControlStateNormal];
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
}

#pragma tableView delegate---------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
    
    UILabel *taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 180.0f, 38.0f)];
    taskLabel.backgroundColor = [UIColor clearColor];
    taskLabel.textAlignment = UITextAlignmentCenter;
    taskLabel.text = [_dataSourceArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:taskLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(272.0f, 11.0f, 38.0f, 40.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = [_numberSourceArray objectAtIndex:indexPath.row];
    [cell.contentView addSubview:label];
    
    UIImageView *smileImg = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 35, 35)];
    smileImg.backgroundColor = [UIColor clearColor];
    smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%d.png",[[_numberSourceArray objectAtIndex:indexPath.row] intValue]]];
    [cell.contentView addSubview:smileImg];
    if (viewNumber !=1) {
        cell.selectionStyle = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (viewNumber == 1) {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"Make sure the task has done?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"NO", nil];
        [alert show];
        selectTask = indexPath.row;
    }else{
        UITableViewCell *cell = [_goodTable cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [PFPush sendPushMessageToChannelInBackground:@"cccc" withMessage:[NSString stringWithFormat:@"%@has done,you get %@ points.",[_dataSourceArray objectAtIndex:selectTask],[_numberSourceArray objectAtIndex:selectTask]]];
        [_dataSourceArray removeObjectAtIndex:selectTask];
        [_numberSourceArray removeObjectAtIndex:selectTask];
        
        [[NSUserDefaults standardUserDefaults] setObject:_numberSourceArray forKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]];
        [[NSUserDefaults standardUserDefaults] setObject:_dataSourceArray forKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]];
        [_goodTable reloadData];
        
        PFObject *anotherPlayer = [PFObject objectWithClassName:@"player"];
        [anotherPlayer setObject:[PFUser currentUser].username forKey:@"userid"];
        [anotherPlayer setObject:[PFUser currentUser].objectId forKey:@"object"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]]) {
            [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] forKey:@"spouse"];
        }
        [anotherPlayer setObject:[PFUser currentUser] forKey:@"username"];
        [anotherPlayer setObject:[NSArray arrayWithArray:_dataSourceArray] forKey:@"task"];
        [anotherPlayer setObject:[NSArray arrayWithArray:_numberSourceArray] forKey:@"score"];
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]] forKey:@"badtask"];
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]] forKey:@"badscore"];
        
        [anotherPlayer saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
            if(succeeded){
                NSLog(@"Object Uploaded");
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error:%@",errorString);
                UIAlertView *uploadAlert = [[UIAlertView alloc] initWithTitle:@"Upload Error" message:@"Upload is failed" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil, nil];
                [uploadAlert show];
            }
        }];
        
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
