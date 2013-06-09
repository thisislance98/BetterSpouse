//
//  BadViewController.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-5.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "BadViewController.h"

@interface BadViewController ()

@end

@implementation BadViewController

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
	UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	_badimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_things.png"]];
    _badimage.Frame = (CGRect){CGPointZero, _badimage.image.size};
    _badimage.center = CGPointMake(_badimage.image.size.width + 40 , _badimage.image.size.height/1.4);
    [self.view addSubview:_badimage];
    
    _remain = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remain.frame = (CGRect){CGPointZero,_remain.image.size};
    _remain.center = CGPointMake(_remain.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remain];
    
    _points = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _points.text = @"25";
    _points.backgroundColor = [UIColor clearColor];
    _points.textAlignment = UITextAlignmentCenter;
    [_remain addSubview:_points];
    
    _badThingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _badimage.frame.size.height+26, 320, self.view.frame.size.height -_badimage.frame.size.height - _remain.frame.size.height-32) style:UITableViewStylePlain];
    _badThingTable.backgroundColor = [UIColor clearColor];
    _badThingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _badThingTable.delegate = self;
    _badThingTable.dataSource = self;
    [self.view addSubview:_badThingTable];
    
    UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    badBtn.frame = (CGRect){CGPointZero,_remain.image.size.width/3,_remain.image.size.height/1.5};
    badBtn.center = CGPointMake(_remain.image.size.width/4 - 10, self.view.frame.size.height-23);
    [badBtn setTitle:@"bad" forState:UIControlStateNormal];
    [badBtn addTarget:self action:@selector(badBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:badBtn];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dailyBtn.frame = (CGRect){CGPointZero,_remain.image.size.width/3,_remain.image.size.height/1.5};
    dailyBtn.center = CGPointMake(_remain.image.size.width/2+10, self.view.frame.size.height-23);
    [dailyBtn setTitle:@"daily" forState:UIControlStateNormal];
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
}

#pragma tableView delegate---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    taskLabel.text = @"Much Rubish";
    [cell.contentView addSubview:taskLabel];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(272.0f, 11.0f, 38.0f, 40.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"-3";
    [cell.contentView addSubview:label];
    
    UIImageView *smileImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 34, 34)];
    smileImg.backgroundColor = [UIColor clearColor];
    smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%@.png",label.text]];
    [cell.contentView addSubview:smileImg];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
