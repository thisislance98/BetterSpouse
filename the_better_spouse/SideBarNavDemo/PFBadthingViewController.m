//
//  PFBadthingViewController.m
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFBadthingViewController.h"
#import "LeftSideBarViewController.h"
#import "PFRewardsViewController.h"
#import "SidebarViewController.h"
#import "PFGoodCell.h"

@interface PFBadthingViewController ()
@property (nonatomic, strong)UIImageView *badImage;
@property (nonatomic, strong)UIImageView *remainPoint;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong)UIView *numberView;
@property (nonatomic, strong) PFGoodCell *ce;

@end

@implementation PFBadthingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _ce = [[PFGoodCell alloc] init];
        _BadSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]]];
        _badNumberArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]]];
        _tagNum = _BadSourceArray.count;
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
    _pointLabel.backgroundColor = [UIColor clearColor];
    _pointLabel.textAlignment = UITextAlignmentCenter;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@badremain",[PFUser currentUser]]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat: @"%@badremain",[PFUser currentUser]]];
        _pointLabel.text = @"-50";
        [[NSUserDefaults standardUserDefaults] setObject:@"-50" forKey:[NSString stringWithFormat: @"%@badremainpoint",[PFUser currentUser]]];
    }else{
        _pointLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@badremainpoint",[PFUser currentUser]]];
    }
    [_remainPoint addSubview:_pointLabel];
    
    _badthingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _badImage.frame.size.height+26, 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32) style:UITableViewStylePlain];
    _badthingTable.backgroundColor = [UIColor clearColor];
    _badthingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _badthingTable.delegate = self;
    _badthingTable.dataSource = self;
    [self.view addSubview:_badthingTable];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.Frame = (CGRect){CGPointZero, _badImage.image.size};
    dailyBtn.center = CGPointMake(_badImage.image.size.width + 40 , _badImage.image.size.height/1.4);
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
    
    UIImageView *numberImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_smiles_bg.png"]];
    numberImage.Frame = (CGRect){CGPointZero, numberImage.image.size};
    
    _numberView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, numberImage.image.size}];
    [_numberView addSubview:numberImage];
    _numberView.hidden = YES;
    [self.view addSubview:_numberView];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"bad_smiles_1.png", @"bad_smiles_2.png",@"bad_smiles_3.png",@"bad_smiles_4.png",@"bad_smiles_5.png",nil];
    
    UIImageView *choiceImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [choiceImage1 setImage:[UIImage imageNamed:[imageArray objectAtIndex:0]]];
    UIImageView *choiceImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [choiceImage2 setImage:[UIImage imageNamed:[imageArray objectAtIndex:1]]];
    UIImageView *choiceImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [choiceImage3 setImage:[UIImage imageNamed:[imageArray objectAtIndex:2]]];
    UIImageView *choiceImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [choiceImage4 setImage:[UIImage imageNamed:[imageArray objectAtIndex:3]]];
    UIImageView *choiceImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [choiceImage5 setImage:[UIImage imageNamed:[imageArray objectAtIndex:4]]];
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setFrame:CGRectMake(10, 20, 50, 70)];
    [firstBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn addSubview:choiceImage1];
    [firstBtn setTag:-1];
    [_numberView addSubview:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setFrame:CGRectMake(68, 20, 50, 70)];
    [secondBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn addSubview:choiceImage2];
    [secondBtn setTag:-2];
    [_numberView addSubview:secondBtn];
    
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setFrame:CGRectMake(126, 20, 50, 70)];
    [thirdBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn addSubview:choiceImage3];
    [thirdBtn setTag:-3];
    [_numberView addSubview:thirdBtn];
    
    UIButton *forthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forthBtn setFrame:CGRectMake(184, 20, 50, 70)];
    [forthBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forthBtn addSubview:choiceImage4];
    [forthBtn setTag:-4];
    [_numberView addSubview:forthBtn];
    
    UIButton *fifthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fifthBtn setFrame:CGRectMake(242, 20, 50, 70)];
    [fifthBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fifthBtn addSubview:choiceImage5];
    [fifthBtn setTag:-5];
    [_numberView addSubview:fifthBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_BadSourceArray.count == 0) {
        return 1;
    }else
        return _tagNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BadID";
    PFGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[PFGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.beDelegate = self;
    }
    
    if (_BadSourceArray.count == 0 || _BadSourceArray.count == indexPath.row) {
        [cell setcontentWithImage:nil task:nil number:nil];
    }else{
        [cell setcontentWithImage:[[_badNumberArray objectAtIndex:indexPath.row] intValue] task:[_BadSourceArray objectAtIndex:indexPath.row] number:[[_badNumberArray objectAtIndex:indexPath.row] intValue]];
    }
    return cell;
}

- (void)buttonPressedAction
{
    _tagNum = _BadSourceArray.count + 1;
    [_badthingTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)dailyBtnClicked
{
    PFObject *anotherPlayer = [PFObject objectWithClassName:@"player"];
    [anotherPlayer setObject:[PFUser currentUser] forKey:@"username"];
    if (_BadSourceArray.count == 0) {
  
        [anotherPlayer setObject:[PFUser currentUser].username forKey:@"userid"];
        
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]] forKey:@"task"];
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]] forKey:@"score"];
        [anotherPlayer save];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]]) {
            [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] forKey:@"spouse"];
        }
        if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
        {
            [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
        }
    }else{
        [anotherPlayer setObject:[PFUser currentUser].username forKey:@"userid"];
        [anotherPlayer setObject:[PFUser currentUser].objectId forKey:@"object"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]]) {
            [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]] forKey:@"spouse"];
        }
        [anotherPlayer setObject:[NSArray arrayWithArray:_BadSourceArray] forKey:@"badtask"];
        [anotherPlayer setObject:[NSArray arrayWithArray:_badNumberArray] forKey:@"badscore"];
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]] forKey:@"task"];
        [anotherPlayer setObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]] forKey:@"score"];
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
    }
}
- (void)showNumberImage:(UIButton *)sender{
    
    UITableViewCell* buttonCell = (UITableViewCell*)[sender superview].superview;
    NSIndexPath *indexPath_1=[_badthingTable indexPathForCell:buttonCell];
    _row = indexPath_1.row;
    [UIView animateWithDuration:0.5f animations:^{
        _numberView.hidden = !_numberView.hidden;
    }];
}

- (void)tableViewCGpointChange:(UITextField *)sender;
{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_badthingTable indexPathForCell:cell];
    _text = indexPath.row;
    _badthingTable.frame = CGRectMake(0, _badImage.frame.size.height+26 , 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32- 160);
}

- (void)tableViewCGpointNormal
{
    _badthingTable.frame = CGRectMake(0, _badImage.frame.size.height+26, 320, self.view.frame.size.height -_badImage.frame.size.height - _remainPoint.frame.size.height-32);
}

- (void)numberofButtonClicked:(id)sender
{
    _number = ((UIButton *)sender).tag;
    if (_badNumberArray.count >= _row +1) {
        NSString *remberNum = [NSString stringWithFormat:@"%d",[_pointLabel.text intValue] + [[_badNumberArray objectAtIndex:_row] intValue]];
        [_badNumberArray replaceObjectAtIndex:_row withObject:[NSString stringWithFormat:@"%d",_number]];
        _pointLabel.text = [NSString stringWithFormat:@"%d",[remberNum intValue] - _number];
        [[NSUserDefaults standardUserDefaults] setObject:_pointLabel.text forKey:@"badremainpoint"];
    }else{
        [_badNumberArray addObject:[NSString stringWithFormat:@"%d",_number]];
        _pointLabel.text = [NSString stringWithFormat:@"%d",[_pointLabel.text intValue] - _number];
        [[NSUserDefaults standardUserDefaults] setObject:_pointLabel.text forKey:[NSString stringWithFormat: @"%@badremainpoint",[PFUser currentUser]]];
    }
    NSLog(@"Nmudata:%@",_badNumberArray);
    [[NSUserDefaults standardUserDefaults] setObject:_badNumberArray forKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]];
    _numberView.hidden = YES;
    [_badthingTable reloadData];
    
}

- (void)getTaskString:(NSString *)inputText
{
    if (_BadSourceArray.count >= _text +1) {
        [_BadSourceArray replaceObjectAtIndex:_text withObject:inputText];
        [_badthingTable reloadData];
    }else{
        [_BadSourceArray addObject:inputText];
    }
    
    _tagNum = _BadSourceArray.count;
    [[NSUserDefaults standardUserDefaults] setObject:_BadSourceArray forKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end