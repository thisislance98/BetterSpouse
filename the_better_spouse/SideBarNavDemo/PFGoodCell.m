//
//  PFGoodCell.m
//  the_better_spouse
//
//  Created by chenxin on 13-5-30.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import "PFGoodCell.h"
#import "PFGoodthingViewController.h"
#import "PFBadthingViewController.h"

@interface PFGoodCell ()
@property (nonatomic, strong) PFGoodthingViewController *goodView;
@property (nonatomic, strong) PFBadthingViewController *badView;
@end

@implementation PFGoodCell
@synthesize beDelegate;
@synthesize NumBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _identifier = reuseIdentifier;
         _goodView = [[PFGoodthingViewController alloc] init];
        _badView = [[PFBadthingViewController alloc] init];
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

- (void)setcontentWithImage:(UIImage *)image task:(NSString *)task number:(int)number
{
    [NumBtn setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    _smileImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"smile%@.png",NumBtn.titleLabel.text]];
}

- (void)buttonPressedClicked
{
    [beDelegate buttonPressedAction];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [beDelegate tableViewCGpointChange];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [beDelegate tableViewCGpointNormal];
    if ([_identifier isEqualToString:@"ID"]) {
       
        [_goodView.dataSourceArray addObject:_inputTextfiled.text];
        NSLog(@"good:%@",_goodView.dataSourceArray);
    }else{
        [_badView.BadSourceArray addObject:_inputTextfiled.text];
        NSLog(@"bad:%@",_badView.BadSourceArray);
    }
    return YES;
}

- (void)buttonPressedAction:(UIButton *)sender
{
    int btnTag = ((UIButton *)sender).tag;
    [beDelegate showNumberImage:btnTag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
