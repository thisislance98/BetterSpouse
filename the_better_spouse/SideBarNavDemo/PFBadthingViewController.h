//
//  PFBadthingViewController.h
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFGoodCell.h"
@interface PFBadthingViewController :UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,goodCelldelegate>{
    UITableView     *_badthingTable;
    UITextField     *_inputTextfiled;
    UIButton        *_NumBtn;
    UIImageView     *_numberImage;
    UILabel         *_pointLabel;
    NSInteger        _tagNum;
    NSInteger       _row;
    NSInteger       _text;

}
@property (nonatomic, strong) NSMutableArray *BadSourceArray;
@property (nonatomic, strong) NSMutableArray *badNumberArray;
@end
