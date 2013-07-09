//
//  PFRewardsCell.h
//  the_better_spouse
//
//  Created by chenxin on 13-7-8.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol rewardsCelldelegate <NSObject>
- (void)tableCGpointChange:(UITextField *)sender;
- (void)tableCGpointNormal:(UITextField *)textField;
- (void)buttonPressedAction;
@end

@interface PFRewardsCell : UITableViewCell<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITextField *inputTextfiled;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, assign) id<rewardsCelldelegate>delegate;
- (void)setcontentWithRewards:(NSString *)rewards number:(int)number;

@end
