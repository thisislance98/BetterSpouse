//
//  PFRewardsCell.m
//  the_better_spouse
//
//  Created by chenxin on 13-7-8.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "PFRewardsCell.h"
#import "PointsModel.h"
@implementation PFRewardsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.image = [UIImage imageNamed:@"reward_item1.png"];
        
        _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 168.0f, 38.0f)];
        _inputTextfiled.delegate = self;
        _inputTextfiled.tag = 1;
        _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
        _inputTextfiled.returnKeyType = UIReturnKeySend;
        [self.contentView addSubview:_inputTextfiled];
        
        _textFiled = [[UITextField alloc] init];
        _textFiled.delegate = self;
        _textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textFiled.borderStyle = UITableViewCellStyleDefault;
        _textFiled.returnKeyType = UIReturnKeyDefault;
        _textFiled.textAlignment = UITextAlignmentCenter;
        _textFiled.frame = CGRectMake(256.0f, 10.0f, 53.0f, 40.0f);
        _textFiled.tag = 2;
        [self.contentView addSubview:_textFiled];
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"plus_sign.png"]];
        _addBtn.frame = CGRectMake(218.0f, 17.0f, 25.0f, 25.0f);
        [_addBtn addTarget:self action:@selector(rewardsButtonPressedClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview: _addBtn];
    }
    return self;
}

- (void)setcontentWithRewards:(NSString *)rewards number:(int)number
{
    _inputTextfiled.text = rewards;
    _textFiled.text = [NSString stringWithFormat:@"%d",number];
}

- (void)rewardsButtonPressedClicked
{
    if (_textFiled.text == nil || _inputTextfiled.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"Please input all text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [_delegate buttonPressedAction];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [_delegate tableCGpointChange:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_delegate tableCGpointNormal:textField];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
