//
//  PFRewardsViewController.h
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFRewardsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    UITableView     *_rewardsTable;
    UITextField     *_inputTextfiled;
    UIButton        *_NumBtn;
    UIImageView     *_numberImage;
    UILabel         *_pointLabel;
    NSInteger       _selectTextRow;
    UIImageView     *badImage;
    UIButton        * _doneInKeyboardButton;
    NSInteger       cellNumber;
    UITextField     *_textFiled;

}
@end
