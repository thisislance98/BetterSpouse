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

@property (nonatomic, strong) NSMutableArray *rewardsDataArray;
@property (nonatomic, strong) NSMutableArray *rewardsNumberArray;

@end

@implementation PFRewardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _rewardsDataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"rew"]];
        _rewardsNumberArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"rnum"]];
        cellNumber = _rewardsDataArray.count;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	badImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rewards.png"]];
    badImage.Frame = (CGRect){CGPointZero, badImage.image.size};
    badImage.center = CGPointMake(badImage.image.size.width + 40 , badImage.image.size.height/1.4);
    [self.view addSubview:badImage];
    
    _rewardsTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, badImage.frame.size.height+26, 320, self.view.frame.size.height -badImage.frame.size.height) style:UITableViewStylePlain];
    _rewardsTable.backgroundColor = [UIColor clearColor];
    _rewardsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rewardsTable.delegate = self;
    _rewardsTable.dataSource = self;
    [self.view addSubview:_rewardsTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.Frame = (CGRect){CGPointZero, badImage.image.size};
    dailyBtn.center = CGPointMake(badImage.image.size.width + 40 , badImage.image.size.height/1.4);
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_rewardsDataArray.count == 0) {
        return 1;
    }else{
        return cellNumber;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"reward_item1.png"];
    
    _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 168.0f, 38.0f)];
    _inputTextfiled.delegate = self;
    _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
    _inputTextfiled.returnKeyType = UIReturnKeySend;
    if (_rewardsDataArray.count == 0 || _rewardsDataArray.count == indexPath.row) {
        _inputTextfiled.text =nil;
    }else{
        _inputTextfiled.text = [_rewardsDataArray objectAtIndex:indexPath.row];
    }
    _inputTextfiled.tag = 1;
    [cell.contentView addSubview:_inputTextfiled];
    
    _textFiled = [[UITextField alloc] init];
    _textFiled.delegate = self;
    _textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textFiled.borderStyle = UITableViewCellStyleDefault;
    _textFiled.returnKeyType = UIReturnKeyDefault;
    _textFiled.textAlignment = UITextAlignmentCenter;
    _textFiled.frame = CGRectMake(256.0f, 10.0f, 53.0f, 40.0f);
    _textFiled.tag = 2;
    if (_rewardsDataArray.count == 0 || _rewardsDataArray.count == indexPath.row) {
        _textFiled.text = nil;
    }else{
        _textFiled.text = [_rewardsNumberArray objectAtIndex:indexPath.row];
    }
    [cell.contentView addSubview:_textFiled];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"plus_sign.png"]];
    addBtn.frame = CGRectMake(218.0f, 17.0f, 25.0f, 25.0f);
    [addBtn addTarget:self action:@selector(buttonPressedClicked) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview: addBtn];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)buttonPressedClicked
{
    if (_inputTextfiled.text == nil || _textFiled.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input all text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        cellNumber= _rewardsDataArray.count + 1;
        [_rewardsTable reloadData];
    }
}

- (void)dailyBtnClicked
{
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
    {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger textNum = ((UITextField *)textField).tag;
    UITableViewCell *cell = (UITableViewCell *)[textField superview].superview;
    NSIndexPath *indexPath = [_rewardsTable indexPathForCell:cell];
    _selectTextRow = indexPath.row;
    if (textNum == 2) {
        if (_inputTextfiled.text == nil) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input task first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertview show];
        }else{
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
    }
    _rewardsTable.frame = CGRectMake(0, badImage.frame.size.height+26 , 320, self.view.frame.size.height -badImage.frame.size.height - 30- 190);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSInteger textNum = ((UITextField *)textField).tag;
    
    if (textNum == 1) {
        if (_rewardsDataArray.count >= _selectTextRow +1) {
            [_rewardsDataArray replaceObjectAtIndex:_selectTextRow withObject:_inputTextfiled.text];
        }else{
            [_rewardsDataArray addObject:_inputTextfiled.text];
        }
         NSLog(@"_rewards:%@",_rewardsDataArray);
        [[NSUserDefaults standardUserDefaults] setObject:_rewardsDataArray forKey:@"rew"];
    }else{
        if (_rewardsNumberArray.count >= _selectTextRow+1) {
            [_rewardsNumberArray replaceObjectAtIndex:_selectTextRow withObject:_textFiled.text];
        }else{
            [_rewardsNumberArray addObject:_textFiled.text];
        }
        NSLog(@"_rewardNum:%@",_rewardsNumberArray);
        [[NSUserDefaults standardUserDefaults] setObject:_rewardsNumberArray forKey:@"rnum"];
    }
    _rewardsTable.frame = CGRectMake(0, badImage.frame.size.height+26 , 320, self.view.frame.size.height -badImage.frame.size.height - 30);
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of
}

@end