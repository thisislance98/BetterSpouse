//
//  PFGoodthingViewController.m
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFGoodthingViewController.h"
#import "PFBadthingViewController.h"
#import "SidebarViewController.h"
#import <Parse/PFObject.h>
#import "PFGoodCell.h"
#import "PointsModel.h"

@interface PFGoodthingViewController ()
@property (nonatomic, strong) UIButton *goBadBtn;
@property (nonatomic, strong) UIImageView *goodImage;
@property (nonatomic, strong) UIImageView *remainPoints;
@property (nonatomic, strong) UIView *numberView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PFGoodCell *ce;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSArray *indexArray;
@end

@implementation PFGoodthingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _ce = [[PFGoodCell alloc] init];
        
        _dataSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]]];
        NSLog(@"data:%@",_dataSourceArray);
        _numberSourceArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]]];
        _tagNum = _dataSourceArray.count;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
//    _defaultView = [[DefaultSettingsViewController alloc] init];
//    _defaultView.delegate = self;
    
	_goodImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_things.png"]];
    _goodImage.Frame = (CGRect){CGPointZero, _goodImage.image.size};
    _goodImage.center = CGPointMake(_goodImage.image.size.width + 40 , _goodImage.image.size.height/1.4);
    [self.view addSubview:_goodImage];
    
    _remainPoints = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remainPoints.frame = (CGRect){CGPointZero,_remainPoints.image.size};
    _remainPoints.center = CGPointMake(_remainPoints.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remainPoints];
    
    _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _pointLabel.backgroundColor = [UIColor clearColor];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@point",[PFUser currentUser]]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@point",[PFUser currentUser]]];
        _pointLabel.text = @"50";
        [[NSUserDefaults standardUserDefaults] setObject:@"50" forKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
    }else{
        _pointLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
    }
    _pointLabel.textAlignment = UITextAlignmentCenter;
    [_remainPoints addSubview:_pointLabel];
    
    _goodthingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _goodImage.frame.size.height+26, 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoints.frame.size.height-32) style:UITableViewStylePlain];
    _goodthingTable.backgroundColor = [UIColor clearColor];
    _goodthingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodthingTable.delegate = self;
    _goodthingTable.dataSource = self;
    [self.view addSubview:_goodthingTable];
    
    UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [badBtn setImage:[UIImage imageNamed:@"continue_btn.png"] forState:UIControlStateNormal];
    [badBtn setImage:[UIImage imageNamed:@"continue_btn_down.png"] forState:UIControlStateHighlighted];
    badBtn.frame = CGRectMake(5, self.view.frame.size.height - 35,131 , 43);
    [badBtn addTarget:self action:@selector(badBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:badBtn];
    
    //    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    dailyBtn.frame = (CGRect){CGPointZero,_remainPoints.image.size.width/3,_remainPoints.image.size.height/1.5};
    //    dailyBtn.center = CGPointMake(_remainPoints.image.size.width/2+10, self.view.frame.size.height-23);
    //    [dailyBtn setTitle:@"daily" forState:UIControlStateNormal];
    //    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:dailyBtn];
    
    _numberImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_smiles_bg.png"]];
    _numberImage.Frame = (CGRect){CGPointZero, _numberImage.image.size};
    
    _numberView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, _numberImage.image.size}];
    [_numberView addSubview:_numberImage];
    _numberView.hidden = YES;
    [self.view addSubview:_numberView];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"good_smiles_1.png", @"good_smiles_2.png",@"good_smiles_3.png",@"good_smiles_4.png",@"good_smiles_5.png",nil];
    
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
    [firstBtn setTag:1];
    [_numberView addSubview:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn setFrame:CGRectMake(68, 20, 50, 70)];
    [secondBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn addSubview:choiceImage2];
    [secondBtn setTag:2];
    [_numberView addSubview:secondBtn];
    
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setFrame:CGRectMake(126, 20, 50, 70)];
    [thirdBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn addSubview:choiceImage3];
    [thirdBtn setTag:3];
    [_numberView addSubview:thirdBtn];
    
    UIButton *forthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forthBtn setFrame:CGRectMake(184, 20, 50, 70)];
    [forthBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [forthBtn addSubview:choiceImage4];
    [forthBtn setTag:4];
    [_numberView addSubview:forthBtn];
    
    UIButton *fifthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fifthBtn setFrame:CGRectMake(242, 20, 50, 70)];
    [fifthBtn addTarget:self action:@selector(numberofButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fifthBtn addSubview:choiceImage5];
    [fifthBtn setTag:5];
    [_numberView addSubview:fifthBtn];
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - 50.0f,320.0f, 1.0f)];
    _inputView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底部工具栏.png"]];
    [self.view addSubview:_inputView];
}

#pragma tableView delegate---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSourceArray.count == 0) {
        return 1;
    }else
        return _tagNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ID";
    PFGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[PFGoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.beDelegate = self;
    }
    if (_dataSourceArray.count == 0 || _dataSourceArray.count == indexPath.row) {
        [cell setcontentWithImage:nil task:nil number:nil];
    }else{
        [cell setcontentWithImage:[[_numberSourceArray objectAtIndex:indexPath.row] intValue] task:[_dataSourceArray objectAtIndex:indexPath.row] number:[[_numberSourceArray objectAtIndex:indexPath.row] intValue]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

#pragma defaultSetting delegate

- (void)goodTableViewReload:(PointsModel *)data{
    _model = data;
    [_dataSourceArray addObjectsFromArray:_model.taskArray];
    NSLog(@"data:%@",_dataSourceArray);
    [_numberSourceArray addObjectsFromArray:_model.scoreArray];
    _tagNum = _dataSourceArray.count;
    [_goodthingTable reloadData];
}

#pragma PFGoodcell Delegate

- (void)showNumberImage:(UIButton *)sender{
    
    UITableViewCell* buttonCell = (UITableViewCell*)[sender superview].superview;
    NSIndexPath *indexPath_1=[_goodthingTable indexPathForCell:buttonCell];
    selectRow = indexPath_1.row;
    [UIView animateWithDuration:0.5f animations:^{
        _numberView.hidden = !_numberView.hidden;
    }];
}

- (void)tableViewCGpointChange:(UITextField *)sender;
{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_goodthingTable indexPathForCell:cell];
    textRow = indexPath.row;
    _goodthingTable.frame = CGRectMake(0, _goodImage.frame.size.height+26 , 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoints.frame.size.height-32- 160);
    [_goodthingTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)tableViewCGpointNormal
{
    _goodthingTable.frame = CGRectMake(0, _goodImage.frame.size.height+26, 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoints.frame.size.height-32);
}

- (void)badBtnClicked
{
    PFBadthingViewController *badView = [[PFBadthingViewController alloc] init];
    [self.navigationController pushViewController:badView animated:YES];
}

#pragma button cliecked

- (void)buttonPressedAction
{
    _tagNum = _dataSourceArray.count + 1;
    [_goodthingTable reloadData];
}

//- (void)dailyBtnClicked
//{
//    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
//    {
//        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
//    }
//}

- (void)numberofButtonClicked:(id)sender
{
    _number = ((UIButton *)sender).tag;
    if (_numberSourceArray.count >= selectRow +1) {
        NSString *remberNum = [NSString stringWithFormat:@"%d",[_pointLabel.text intValue] + [[_numberSourceArray objectAtIndex:selectRow] intValue]];
        [_numberSourceArray replaceObjectAtIndex:selectRow withObject:[NSString stringWithFormat:@"%d",_number]];
        _pointLabel.text = [NSString stringWithFormat:@"%d",[remberNum intValue] - _number];
        [[NSUserDefaults standardUserDefaults] setObject:_pointLabel.text forKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
    }else{
        [_numberSourceArray addObject:[NSString stringWithFormat:@"%d",_number]];
        _pointLabel.text = [NSString stringWithFormat:@"%d",[_pointLabel.text intValue] - _number];
        [[NSUserDefaults standardUserDefaults] setObject:_pointLabel.text forKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
    }
    NSLog(@"Nmudata:%@",_numberSourceArray);
    [[NSUserDefaults standardUserDefaults] setObject:_numberSourceArray forKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]];
    _numberView.hidden = YES;
    [_goodthingTable reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:_pointLabel.text forKey:[NSString stringWithFormat:@"%@remainpoint",[PFUser currentUser]]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

- (void)getTaskString:(NSString *)inputText
{
    if (_dataSourceArray.count >= textRow +1) {
        [_dataSourceArray replaceObjectAtIndex:textRow withObject:inputText];
        [_goodthingTable reloadData];
    }else{
        [_dataSourceArray addObject:inputText];
    }
    [[NSUserDefaults standardUserDefaults] setObject:_dataSourceArray forKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]];
    _tagNum = _dataSourceArray.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
