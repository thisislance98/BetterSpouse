//
//  PFGoodCell.h
//  the_better_spouse
//
//  Created by chenxin on 13-5-30.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol goodCelldelegate <NSObject>
- (void)showNumberImage:(UIButton *)sender;
- (void)tableViewCGpointChange:(UITextField *)sender;
- (void)tableViewCGpointNormal;
- (void)buttonPressedAction;
- (void)buttonPressedClicked;
- (void)getTaskString:(NSString *)inputText;
@end

@interface PFGoodCell : UITableViewCell<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) id<goodCelldelegate> beDelegate;
@property (nonatomic, strong) UIButton *NumBtn;
@property (nonatomic, strong) UIImageView *smileImg;
@property (nonatomic, strong) NSMutableArray *imaegArray;
@property (nonatomic, strong) UITextField *inputTextfiled;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *minusBtn;
- (void)setcontentWithImage:(int)imageNumber task:(NSString *)task number:(int)number totalCount:(int)count;
@end
