//
//  PFGoodCell.m
//  the_better_spouse
//
//  Created by chenxin on 13-5-30.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFGoodCell.h"
#import "PFGoodthingViewController.h"
@implementation PFGoodCell
@synthesize beDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.image = [UIImage imageNamed:@"blank_list2.png"];
        _inputTextfiled = [[UITextField alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 180.0f, 38.0f)];
        _inputTextfiled.delegate = self;
        _inputTextfiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _inputTextfiled.borderStyle = UITableViewCellStyleDefault;
        _inputTextfiled.returnKeyType = UIReturnKeySend;
        //_inputTextfiled.text = @"take the trash out";
        [self.contentView addSubview:_inputTextfiled];
        
        _NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_NumBtn setTitle:@"2" forState:UIControlStateNormal];
        [_NumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _NumBtn.frame = CGRectMake(272.0f, 11.0f, 38.0f, 40.0f);
        [_NumBtn addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_NumBtn];
        
        _smileImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 34, 34)];
        _smileImg.image = [UIImage imageNamed:@"smile1.png"];
        _smileImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_smileImg];
//        _Label = [[UILabel alloc] initWithFrame:CGRectMake(272.0f, 11.0f, 38.0f, 40.0f)];
//        _Label.backgroundColor = [UIColor grayColor];
//        _Label.textAlignment = UITextAlignmentCenter;
//        [self.contentView addSubview:_Label];
    }
    return self;
}

- (void)setcontentWith:(UIImage *)image task:(NSString *)task number:(int)number
{
    [_NumBtn setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
    NSLog(@"____%d",number);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [beDelegate tableViewCGpointChange];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [beDelegate tableViewCGpointNormal];
    return YES;
}

- (void)buttonPressedAction:(UIButton *)sender
{
    [beDelegate showNumberImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
