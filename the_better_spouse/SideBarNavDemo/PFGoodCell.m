//
//  PFGoodCell.m
//  the_better_spouse
//
//  Created by chenxin on 13-5-30.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFGoodCell.h"
#import "PointsModel.h"

@interface PFGoodCell ()
@end

@implementation PFGoodCell
@synthesize beDelegate;
@synthesize NumBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _identifier = reuseIdentifier;
        
        self.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
        _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 180.0f, 38.0f)];
        _inputTextfiled.delegate = self;
        _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
        _inputTextfiled.returnKeyType = UIReturnKeySend;
        [self.contentView addSubview:_inputTextfiled];
        
        NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [NumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NumBtn.frame = CGRectMake(272.0f, 11.0f, 38.0f, 40.0f);
        NumBtn.tag = self.tag;
        [NumBtn addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:NumBtn];
        
        _smileImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 34, 34)];
        _smileImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_smileImg];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"plus_sign.png"]];
        addBtn.frame = CGRectMake(228.0f, 17.0f, 25.0f, 25.0f);
        [addBtn addTarget:self action:@selector(buttonPressedClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview: addBtn];
    }
    return self;
}

- (void)setcontentWithImage:(int)imageNumber task:(NSString *)task number:(int)number
{
    [NumBtn setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    _smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%d.png",imageNumber]];
    _inputTextfiled.text = task;
}

- (void)buttonPressedClicked
{
    if (NumBtn.titleLabel.text == nil || _inputTextfiled.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input all text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [beDelegate buttonPressedAction];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [beDelegate tableViewCGpointChange:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [beDelegate tableViewCGpointNormal];
    PointsModel *points = [[PointsModel alloc] init];
    if ([_identifier isEqualToString:@"ID"]) {
        points.goodHabits = _inputTextfiled.text;
        [beDelegate getTaskString:points.goodHabits];
    }else{
        points.badHabits = _inputTextfiled.text;
        [beDelegate getTaskString:points.badHabits];
    }
    return YES;
}

- (void)buttonPressedAction:(UIButton *)sender
{
    if (_inputTextfiled.text == nil) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input task first" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertview show];
    }else{
    [beDelegate showNumberImage:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
