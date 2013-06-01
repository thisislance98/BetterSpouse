//
//  PFRewardsViewController.h
//  The Better Spouse
//
//  Created by chenxin on 13-5-28.
//  Copyright (c) 2013年 zechir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFRewardsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView     *_goodthingTable;
    UITextField     *_inputTextfiled;
    UIButton        *_NumBtn;
    UIImageView     *_numberImage;
    UILabel         *_pointLabel;
}
@end
