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
@end

@implementation PFGoodthingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ce = [[PFGoodCell alloc] init];
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
        _tagNum = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"list_background.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
	_goodImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_things.png"]];
    _goodImage.Frame = (CGRect){CGPointZero, _goodImage.image.size};
    _goodImage.center = CGPointMake(_goodImage.image.size.width + 40 , _goodImage.image.size.height/1.4);
    [self.view addSubview:_goodImage];
    
    _remainPoints = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"remaining_pts.png"]];
    _remainPoints.frame = (CGRect){CGPointZero,_remainPoints.image.size};
    _remainPoints.center = CGPointMake(_remainPoints.image.size.width+47, self.view.frame.size.height-23);
    [self.view addSubview:_remainPoints];
    
    _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(134, 9, 35, 26)];
    _pointLabel.text = @"25";
    _pointLabel.backgroundColor = [UIColor clearColor];
    _pointLabel.textAlignment = UITextAlignmentCenter;
    [_remainPoints addSubview:_pointLabel];
    
    _goodthingTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, _goodImage.frame.size.height+26, 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoints.frame.size.height-32) style:UITableViewStylePlain];
    _goodthingTable.backgroundColor = [UIColor clearColor];
    _goodthingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _goodthingTable.delegate = self;
    _goodthingTable.dataSource = self;
    [self.view addSubview:_goodthingTable];
    
    UIButton *badBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    badBtn.frame = (CGRect){CGPointZero,_remainPoints.image.size.width/3,_remainPoints.image.size.height/1.5};
    badBtn.center = CGPointMake(_remainPoints.image.size.width/4 - 10, self.view.frame.size.height-23);
    [badBtn setTitle:@"bad" forState:UIControlStateNormal];
    [badBtn addTarget:self action:@selector(badBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:badBtn];
    
    UIButton *dailyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dailyBtn.frame = (CGRect){CGPointZero,_remainPoints.image.size.width/3,_remainPoints.image.size.height/1.5};
    dailyBtn.center = CGPointMake(_remainPoints.image.size.width/2+10, self.view.frame.size.height-23);
    [dailyBtn setTitle:@"daily" forState:UIControlStateNormal];
    [dailyBtn addTarget:self action:@selector(dailyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
    
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
    [cell setcontentWithImage:nil task:nil number:_number];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buttonPressedAction
{
    _tagNum ++;
   [_goodthingTable reloadData];
}
#pragma button cliecked

- (void)showNumberImage:(int)btnTag{
    NSLog(@"selectRoW:%d",selectRow);
    [UIView animateWithDuration:0.5f animations:^{
        _numberView.hidden = !_numberView.hidden;
    }];
}

- (void)tableViewCGpointChange;
{
    _goodthingTable.frame = CGRectMake(0, _goodImage.frame.size.height+26 , 320, self.view.frame.size.height -_goodImage.frame.size.height - _remainPoints.frame.size.height-32- 160);
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

- (void)dailyBtnClicked
{
    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)])
    {
        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
    }
}

- (void)numberofButtonClicked:(id)sender
{
    _number = ((UIButton *)sender).tag;
    //UIButton* button = (UIButton*)sender;
    UITableViewCell* buttonCell = (UITableViewCell*)[sender superview];
    NSUInteger row = [[_goodthingTable indexPathForCell:buttonCell]row];
        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:row inSection:0];
    NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
    [_goodthingTable reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    _numberView.hidden = YES;
    _pointLabel.text = [NSString stringWithFormat:@"%d",[_pointLabel.text intValue] - _number];
}

- (void)getTaskString:(NSString *)inputText
{
    [_dataSourceArray addObject:inputText];
    NSLog(@"bad:%@",_dataSourceArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
