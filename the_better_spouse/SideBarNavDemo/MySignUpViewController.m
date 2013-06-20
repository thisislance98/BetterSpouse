//
//  MySignUpViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//

#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PFGoodthingViewController.h"
#import <Parse/PFUser.h>
#import "FirstViewController.h"
@interface MySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginScreen3_background.png"]]];
    
    //    UIImageView *welcomeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome.png"]];
    //    welcomeIcon.Frame = (CGRect){CGPointZero, welcomeIcon.image.size};
    //    welcomeIcon.center = CGPointMake(welcomeIcon.image.size.width + 35 , self.view.frame.size.height / 13);
    //    [self.view addSubview:welcomeIcon];
    //
    //    UIImageView *betterIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]];
    //    betterIcon.frame = (CGRect){CGPointZero,betterIcon.image.size};
    //    betterIcon.center = CGPointMake(betterIcon.image.size.width/2 + 3,self.view.frame.size.height / 6.5);
    //    [self.view addSubview:betterIcon];
    
    fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_info.png"]];
    fieldsBackground.backgroundColor = [UIColor clearColor];
    fieldsBackground.userInteractionEnabled = YES;
    [self.view addSubview:fieldsBackground];
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(93, 1, fieldsBackground.frame.size.width - 95, fieldsBackground.frame.size.height / 4)];
    [_usernameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _usernameField.returnKeyType = UIReturnKeyNext;
    _usernameField.delegate = self;
    _usernameField.backgroundColor = [UIColor clearColor];
    [fieldsBackground addSubview:_usernameField];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(93, 38, fieldsBackground.frame.size.width - 95, fieldsBackground.frame.size.height / 4)];
    [_passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.secureTextEntry = YES;
    _passwordField.delegate = self;
    _passwordField.backgroundColor = [UIColor clearColor];
    [fieldsBackground addSubview:_passwordField];
    
    _confirmTF = [[UITextField alloc] initWithFrame:CGRectMake(93, 74, fieldsBackground.frame.size.width - 95, fieldsBackground.frame.size.height / 4)];
    [_confirmTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _confirmTF.returnKeyType = UIReturnKeyNext;
    _confirmTF.secureTextEntry = YES;
    _confirmTF.delegate = self;
    _confirmTF.backgroundColor = [UIColor clearColor];
    [fieldsBackground addSubview:_confirmTF];
    
    _numCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_numCountBtn setImage:[UIImage imageNamed:@"create_account0.png"] forState:UIControlStateNormal];
    [_numCountBtn setImage:[UIImage imageNamed:@"create_account1.png"] forState:UIControlStateHighlighted];
    [_numCountBtn addTarget:self action:@selector(newCountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_numCountBtn];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 5, 40, 40)];
    [button addTarget:self action:@selector(comeBackClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)comeBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newCountBtnClicked
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(_usernameField.text  && _passwordField.text &&_confirmTF.text)
    {
        [dic setObject:_usernameField.text forKey:@"username"];
        [dic setObject:_passwordField.text forKey:@"password"];
        [self signUpViewController:(PFSignUpViewController *)self shouldBeginSignUp:dic];
        PFUser *user =[PFUser user];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        
        if ([_confirmTF.text isEqualToString:_passwordField.text]) {
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(!error){
                    PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
                    [self.navigationController pushViewController:googView animated:YES];
                }
            }];
        }else{
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Twice Password is different" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else{
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input all text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_numCountBtn setFrame:CGRectMake(self.view.frame.size.width/7, self.view.frame.size.height / 1.3, 238, 41)];
    self.fieldsBackground.frame = CGRectMake(20, fieldsBackground.frame.size.height*2.3, 281, 98);
    // self.fieldsBackground.center = CGPointMake(self.view.frame.size.width / 2, fieldsBackground.frame.size.height*2.8);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    self.view.frame = CGRectMake(0, -200 , self.view.frame.size.width, self.view.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) {
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
    [self.navigationController pushViewController:googView animated:YES];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

@end
