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
        _rewardsDataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@tempReward",[PFUser currentUser]]]];
        _rewardsNumberArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@tempRewardsNum",[PFUser currentUser]]]];
        NSLog(@"count:%@",_rewardsDataArray);
        NSLog(@"number:%@",_rewardsNumberArray);
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
    
    _rewardsTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, badImage.frame.size.height+26, 320, self.view.frame.size.height -badImage.frame.size.height-10) style:UITableViewStylePlain];
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
    PFRewardsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[PFRewardsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    if (_rewardsDataArray.count == 0 || _rewardsDataArray.count == indexPath.row || _rewardsNumberArray.count == 0) {
        [cell setcontentWithRewards:nil number:nil];
    }else if (_rewardsDataArray.count == _rewardsNumberArray.count){
        [cell setcontentWithRewards:[_rewardsDataArray objectAtIndex:indexPath.row] number:[[_rewardsNumberArray objectAtIndex:indexPath.row] intValue]];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(_rewardsDataArray.count != 0){
        [_rewardsNumberArray removeObjectAtIndex:indexPath.row];
        [_rewardsDataArray removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:_rewardsDataArray forKey:[NSString stringWithFormat:@"%@tempReward",[PFUser currentUser]]];
        [[NSUserDefaults standardUserDefaults] setObject:_rewardsNumberArray forKey:[NSString stringWithFormat:@"%@tempRewardsNum",[PFUser currentUser]]];
            cellNumber = _rewardsDataArray.count;
        [_rewardsTable reloadData];
        }
    }
}

- (void)buttonPressedAction
{
    cellNumber= _rewardsDataArray.count + 1;
    [_rewardsTable reloadData];
}

- (void)dailyBtnClicked
{
    PFObject *anotherPlayer = [PFObject objectWithClassName:@"rewards"];
    [anotherPlayer setObject:[PFUser currentUser] forKey:@"username"];
    if (_rewardsNumberArray.count == _rewardsDataArray.count) {
        [anotherPlayer setObject:[PFUser currentUser].username forKey:@"userid"];
        [anotherPlayer setObject:[PFUser currentUser].objectId forKey:@"object"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]]) {
            [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] forKey:@"spouse"];
        }
        [anotherPlayer setObject:[NSArray arrayWithArray:_rewardsDataArray] forKey:@"rewards"];
        [anotherPlayer setObject:[NSArray arrayWithArray:_rewardsNumberArray] forKey:@"rewardsNum"];
        [anotherPlayer saveInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
            if(succeeded){
                NSLog(@"Object Uploaded");
                if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
                {
                    [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
                }
            }
            else{
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                NSLog(@"Error:%@",errorString);
                UIAlertView *uploadAlert = [[UIAlertView alloc] initWithTitle:@"Upload Error" message:@"Upload is failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [uploadAlert show];
            }
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please make sure your rewards is correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma mark - UITextFieldDelegate

- (void)tableCGpointChange:(UITextField *)sender
{
    NSInteger textNum = ((UITextField *)sender).tag;
    UITableViewCell *cell = (UITableViewCell *)[sender superview].superview;
    NSIndexPath *indexPath = [_rewardsTable indexPathForCell:cell];
    _selectTextRow = indexPath.row;
    if (textNum == 2) {
        if (((UITextField *)sender).text == nil && textNum == 1) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input rewards first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertview show];
        }else{
            sender.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
    }
    _rewardsTable.frame = CGRectMake(0, badImage.frame.size.height+26 , 320, self.view.frame.size.height -badImage.frame.size.height - 30- 200);
    [_rewardsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [_rewardsTable scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
}



- (void)tableCGpointNormal:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSInteger textNum = ((UITextField *)textField).tag;
    if (textField.text.length > 0) {
        if (textNum == 1) {
            if (_rewardsDataArray.count >= _selectTextRow +1) {
                [_rewardsDataArray replaceObjectAtIndex:_selectTextRow withObject:((UITextField *)textField).text];
                [_rewardsTable reloadData];
            }else{
                [_rewardsDataArray addObject:((UITextField *)textField).text];
            }
            NSLog(@"_rewards:%@",_rewardsDataArray);
            cellNumber = _rewardsDataArray.count;
            [[NSUserDefaults standardUserDefaults] setObject:_rewardsDataArray forKey:[NSString stringWithFormat:@"%@tempReward",[PFUser currentUser]]];
        }else{
            if (_rewardsNumberArray.count >= _selectTextRow+1) {
                [_rewardsNumberArray replaceObjectAtIndex:_selectTextRow withObject:((UITextField *)textField).text];
            }else{
                [_rewardsNumberArray addObject:((UITextField *)textField).text];
            }
            NSLog(@"_rewardNum:%@",_rewardsNumberArray);
            [[NSUserDefaults standardUserDefaults] setObject:_rewardsNumberArray forKey:[NSString stringWithFormat:@"%@tempRewardsNum",[PFUser currentUser]]];
            [_rewardsTable reloadData];
        }
        _rewardsTable.frame = CGRectMake(0, badImage.frame.size.height+26 , 320, self.view.frame.size.height -badImage.frame.size.height - 30);
    }else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input all first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of
}

@end