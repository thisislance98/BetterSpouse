//
//  PFGoodthingViewController.h
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFGoodCell.h"
@interface PFGoodthingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,goodCelldelegate>{
    UITableView     *_goodthingTable;
    UITextField     *_inputTextfiled;
    UIButton        *_NumBtn;
    UIImageView     *_numberImage;
    UILabel         *_pointLabel;
    UIView          *_inputView;
    NSArray         *_tagArray;
    NSInteger        _tagNum;
    NSInteger       selectRow;
}

@property (nonatomic, strong) UILabel *btnLabel;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end
