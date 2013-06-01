//
//  PFGoodCell.h
//  the_better_spouse
//
//  Created by chenxin on 13-5-30.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol goodCelldelegate <NSObject>
- (void)showNumberImage;
- (void)tableViewCGpointChange;
- (void)tableViewCGpointNormal;


@end

@interface PFGoodCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, assign) id<goodCelldelegate> beDelegate;
@property (nonatomic, strong) UIButton *NumBtn;
@property (nonatomic, strong) UIImageView *smileImg;
@property (nonatomic, strong) NSMutableArray *imaegArray;
@property (nonatomic, strong) UITextField *inputTextfiled;
- (void)setcontentWith:(UIImage *)image task:(NSString *)task number:(int)number;
@end
