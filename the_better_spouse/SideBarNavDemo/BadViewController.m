//
//  BadViewController.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "BadViewController.h"
#import "SidebarViewController.h"
@interface BadViewController ()
@property (nonatomic, strong) NSMutableArray *badDataSourceArray;
@property (nonatomic, strong) NSMutableArray *badNumberSourceArray;
@end

@implementation BadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewNumber:(int)number
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        viewNumber = number;
        if (number == 2) {
            _badDataSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]]];
            _badNumberSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]]];
        }else{
            NSString *spouse = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
            _badDataSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badtask",spouse]]];
            _badNumberSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badscore",spouse]]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	_badimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_habits.png"]];
    _badimage.Frame = (CGRect){CGPointZero, _badimage.image.size};
    _badimage.center = CGPointMake(_badimage.image.size.width + 40 , _badimage.image.size.height/1.4);
    [self.view addSubview:_badimage];
    
    _remain = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remain.frame = (CGRect){CGPointZero,_remain.image.size};
    _remain.center = CGPointMake(_remain.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remain];
    
    _points = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _points.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@badremainpoint",[PFUser currentUser]]];
    _points.backgroundColor = [UIColor clearColor];
    _points.textAlignment = UITextAlignmentCenter;
    [_remain addSubview:_points];
    
    _badThingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _badimage.frame.size.height+26, 320, self.view.frame.size.height -_badimage.frame.size.height - _remain.frame.size.height-32) style:UITableViewStylePlain];
    _badThingTable.backgroundColor = [UIColor clearColor];
    _badThingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _badThingTable.delegate = self;
    _badThingTable.dataSource = self;
    [self.view addSubview:_badThingTable];
    
    
    UIButton *badBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [badBtn1 setImage:[UIImage imageNamed:@"continue_btn.png"] forState:UIControlStateNormal];
    [badBtn1 setImage:[UIImage imageNamed:@"continue_btn_down.png"] forState:UIControlStateHighlighted];
    badBtn1.frame = CGRectMake(3, self.view.frame.size.height - 35,131 , 43);
    [badBtn1 addTarget:self action:@selector(badDailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:badBtn1];
    //    UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    badBtn.frame = (CGRect){CGPointZero,_remain.image.size.width/3,_remain.image.size.height/1.5};
    //    badBtn.center = CGPointMake(_remain.image.size.width/4 - 10, self.view.frame.size.height-23);
    //    [badBtn setTitle:@"bad" forState:UIControlStateNormal];
    //    [badBtn addTarget:self action:@selector(badBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:badBtn];
    //
    //    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    dailyBtn.frame = (CGRect){CGPointZero,_remain.image.size.width/3,_remain.image.size.height/1.5};
    //    dailyBtn.center = CGPointMake(_remain.image.size.width/2+10, self.view.frame.size.height-23);
    //    [dailyBtn setTitle:@"daily" forState:UIControlStateNormal];
    //    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:dailyBtn];
}

#pragma tableView delegate---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _badDataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    UILabel *taskLabel = nil;
    UILabel *label = nil;
    UIImageView *smileImg = nil;
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 180.0f, 38.0f)];
        taskLabel.backgroundColor = [UIColor clearColor];
        taskLabel.textAlignment = UITextAlignmentCenter;
        taskLabel.text = [_badDataSourceArray objectAtIndex:indexPath.row];
        
        taskLabel.tag = 1;
        [cell addSubview:taskLabel];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(272.0f, 11.0f, 38.0f, 40.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.text = [_badNumberSourceArray objectAtIndex:indexPath.row];
        
        label.tag = 2;
        [cell addSubview:label];
        
        smileImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 34, 34)];
        smileImg.backgroundColor = [UIColor clearColor];
        smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%@.png",label.text]];
        
        smileImg.tag = 3;
        [cell addSubview:smileImg];
    } else {
        taskLabel = (UILabel *)[cell viewWithTag:1];
        label = (UILabel *)[cell viewWithTag:2];
        smileImg = (UIImageView *)[cell viewWithTag:3];
    }
    
    
    cell.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
    
    taskLabel.text = [_badDataSourceArray objectAtIndex:indexPath.row];
    label.text = [_badNumberSourceArray objectAtIndex:indexPath.row];
    smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%d.png",[[_badNumberSourceArray objectAtIndex:indexPath.row] intValue]]];
    
    if (viewNumber != 2) {
        cell.selectionStyle = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (viewNumber == 2) {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"Make sure the task has done?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"NO", nil];
        alert.tag = 20;
        [alert show];
        selectTask = indexPath.row;
    }else{
        UITableViewCell *cell = [_badThingTable cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 20) {
        if (buttonIndex == 0) {
            
            NSString *spouse = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
            if (spouse != nil) {
                [PFPush sendPushMessageToChannelInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] withMessage:[NSString stringWithFormat:@"you left the %@ out and lost %@ points",[_badDataSourceArray objectAtIndex:selectTask],[_badNumberSourceArray objectAtIndex:selectTask]]];
                [_delegate changeTextfieldNumber:[_badNumberSourceArray objectAtIndex:selectTask]];
                [_badDataSourceArray removeObjectAtIndex:selectTask];
                [_badNumberSourceArray removeObjectAtIndex:selectTask];
                [[NSUserDefaults standardUserDefaults] setObject:_badNumberSourceArray forKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]];
                [[NSUserDefaults standardUserDefaults] setObject:_badDataSourceArray forKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]];
                [_badThingTable reloadData];
                
                PFObject *anotherPlayer = [PFObject objectWithClassName:@"player"];
                if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]]) {
                    [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] forKey:@"spouse"];
                }
                [anotherPlayer setObject:[PFUser currentUser] forKey:@"username"];
                [anotherPlayer setObject:[PFUser currentUser].username forKey:@"userid"];
                [anotherPlayer setObject:[PFUser currentUser].objectId forKey:@"object"];
                [anotherPlayer setObject:[NSArray arrayWithArray:_badDataSourceArray] forKey:@"badtask"];
                [anotherPlayer setObject:[NSArray arrayWithArray:_badNumberSourceArray] forKey:@"badscore"];
                [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]] forKey:@"task"];
                [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]] forKey:@"score"];
                
                [anotherPlayer saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
                    if(succeeded){
                        NSLog(@"Object Uploaded");
                    }
                    else{
                        NSString *errorString = [[error userInfo] objectForKey:@"error"];
                        NSLog(@"Error:%@",errorString);
                        UIAlertView *uploadAlert = [[UIAlertView alloc] initWithTitle:@"Upload Error" message:@"Upload is failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [uploadAlert show];
                    }
                }];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You has not a friend" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}

- (void)changeBadTextfieldNumber:(NSString *)number{
    int  tempNum = [number intValue];
    NSLog(@"tempNum = %d",tempNum);
    int  nativeNum =[[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badremainpoint",[PFUser currentUser]]] intValue];
    _points.text = [NSString stringWithFormat:@"%d",nativeNum+tempNum];
    [[NSUserDefaults standardUserDefaults] setObject:_points.text forKey:[NSString stringWithFormat:@"%@badremainpoint",[PFUser currentUser]]];
}

- (void)badDailyBtnClicked
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
