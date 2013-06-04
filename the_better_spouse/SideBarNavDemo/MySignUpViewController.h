//
//  MySignUpViewController.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//
#import <Parse/Parse.h>

@class PFSignUpViewController;
@interface MySignUpViewController : UIViewController<PFSignUpViewControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *confirmTF;
@property (nonatomic, strong) UIButton *numCountBtn;
@property (nonatomic, strong) PFSignUpViewController *signUpView;
@end
