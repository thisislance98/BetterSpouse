//
//  PFAddSpouseViewController.h
//  the_better_spouse
//
//  Created by chenxin on 13-6-20.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFAddSpouseViewController : UIViewController<UITextFieldDelegate>{
    UIImageView *spouseInfo;
    NSString *tempString;
}

@property (nonatomic, strong) UITextField *userText;
@property (nonatomic, strong) UITextField *emailText;

@end
