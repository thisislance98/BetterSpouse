//
//  PFRewardsViewController.m
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFRewardsViewController.h"
#import "LeftSideBarViewController.h"
#import "SidebarViewController.h"
@interface PFRewardsViewController ()

@end

@implementation PFRewardsViewController

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
    
	UIImageView *badImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rewards.png"]];
    badImage.Frame = (CGRect){CGPointZero, badImage.image.size};
    badImage.center = CGPointMake(badImage.image.size.width + 40 , badImage.image.size.height/1.4);
    [self.view addSubview:badImage];
    
       _goodthingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, badImage.frame.size.height+26, 320, self.view.frame.size.height -badImage.frame.size.height) style:UITableViewStylePlain];
    _goodthingTable.backgroundColor = [UIColor clearColor];
    _goodthingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodthingTable.delegate = self;
    _goodthingTable.dataSource = self;
    [self.view addSubview:_goodthingTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.Frame = (CGRect){CGPointZero, badImage.image.size};
    dailyBtn.center = CGPointMake(badImage.image.size.width + 40 , badImage.image.size.height/1.4);
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
    
    _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 210.0f, 38.0f)];
    _inputTextfiled.delegate = self;
    _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
    _inputTextfiled.returnKeyType = UIReturnKeySend;
    _inputTextfiled.text = @"Dinner date";
    [cell.contentView addSubview:_inputTextfiled];
    
    _NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _NumBtn.frame = CGRectMake(272.0f, 11.0f, 38.0f, 40.0f);
    [_NumBtn addTarget:self action:@selector(numberButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:_NumBtn];
    
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 38, 40)];
    btnLabel.text = @"200";
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.textAlignment = UITextAlignmentCenter;
    [_NumBtn addSubview:btnLabel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (void)dailyBtnClicked
{
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

- (void)numberButtonClicked
{
    _numberImage.hidden = !_numberImage.hidden;
}

- (void)setIDText:(NSString*)idText
{
    _inputTextfiled.text = idText;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputTextfiled resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of
}

@end