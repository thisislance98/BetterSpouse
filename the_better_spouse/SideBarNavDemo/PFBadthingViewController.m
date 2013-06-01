//
//  PFBadthingViewController.m
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFBadthingViewController.h"
#import "PFDailyTrackerViewController.h"
#import "PFRewardsViewController.h"
#import "LeftSideBarViewController.h"
#import "SidebarViewController.h"
@interface PFBadthingViewController ()
@property (nonatomic, strong)UIImageView *badImage;
@property (nonatomic, strong)UIImageView *remainPoint;
@end

@implementation PFBadthingViewController

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
    UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	_badImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_things.png"]];
    _badImage.Frame = (CGRect){CGPointZero, _badImage.image.size};
    _badImage.center = CGPointMake(_badImage.image.size.width + 40 , _badImage.image.size.height/1.4);
    [self.view addSubview:_badImage];
    
    _remainPoint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remainPoint.frame = (CGRect){CGPointZero,_remainPoint.image.size};
    _remainPoint.center = CGPointMake(_remainPoint.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remainPoint];
    
    _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _pointLabel.text = @"25";
    _pointLabel.backgroundColor = [UIColor clearColor];
    _pointLabel.textAlignment = UITextAlignmentCenter;
    [_remainPoint addSubview:_pointLabel];
    
    _numberImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_smiles_bg.png"]];
    _numberImage.Frame = (CGRect){CGPointZero, _numberImage.image.size};
    _numberImage.hidden = YES;
    [self.view addSubview:_numberImage];
    
    _goodthingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _badImage.frame.size.height+26, 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32) style:UITableViewStylePlain];
    _goodthingTable.backgroundColor = [UIColor clearColor];
    _goodthingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodthingTable.delegate = self;
    _goodthingTable.dataSource = self;
    [self.view addSubview:_goodthingTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.Frame = (CGRect){CGPointZero, _badImage.image.size};
    dailyBtn.center = CGPointMake(_badImage.image.size.width + 40 , _badImage.image.size.height/1.4);
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //if (!cell) {
       UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    //}
    
    cell.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
    
    _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 210.0f, 38.0f)];
    _inputTextfiled.delegate = self;
    _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
    _inputTextfiled.returnKeyType = UIReturnKeySend;
    _inputTextfiled.text = @"you are late";
    [cell.contentView addSubview:_inputTextfiled];
    
    _NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _NumBtn.frame = CGRectMake(272.0f, 11.0f, 38.0f, 40.0f);
    [_NumBtn addTarget:self action:@selector(numberButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:_NumBtn];
    
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 38, 40)];
    btnLabel.text = @"5";
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.textAlignment = UITextAlignmentCenter;
    [_NumBtn addSubview:btnLabel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)dailyBtnClicked{
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
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    _goodthingTable.frame = CGRectMake(0, _badImage.frame.size.height+26, 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32-160);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _goodthingTable.frame = CGRectMake(0, _badImage.frame.size.height+26, 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32);
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end