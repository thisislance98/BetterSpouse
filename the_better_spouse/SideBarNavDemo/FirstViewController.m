//
//  FirstViewController.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "FirstViewController.h"
#import "DefaultSettingsViewController.h"
#import "SidebarViewController.h"
#import "SecondViewController.h"
#import "MySignUpViewController.h"
#import "PFAddSpouseViewController.h"

@interface FirstViewController ()
@property (nonatomic, retain) DefaultSettingsViewController *loginORsignController;

@end

@implementation FirstViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_screen.png"]]];
    
    UIImageView *welcomeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome.png"]];
    welcomeIcon.Frame = (CGRect){CGPointZero, welcomeIcon.image.size};
    welcomeIcon.center = CGPointMake(welcomeIcon.image.size.width + 35 , self.view.frame.size.height / 13);
    [self.view addSubview:welcomeIcon];
    
    UIImageView *betterIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title.png"]];
    betterIcon.frame = (CGRect){CGPointZero,betterIcon.image.size};
    betterIcon.center = CGPointMake(betterIcon.image.size.width/2 + 3,self.view.frame.size.height / 6.5);
    [self.view addSubview:betterIcon];
    
    UIButton *faceBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [faceBookBtn setImage:[UIImage imageNamed:@"fblog0.png"] forState:UIControlStateNormal];
    [faceBookBtn setImage:[UIImage imageNamed:@"fblog1.png"] forState:UIControlStateHighlighted];
    [faceBookBtn setFrame:CGRectMake(self.view.frame.size.width/7, self.view.frame.size.height / 1.78, 238, 41)];
    [faceBookBtn addTarget:self action:@selector(faceBookBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faceBookBtn];
    
    UIButton *newCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [newCountBtn setImage:[UIImage imageNamed:@"new_account0.png"] forState:UIControlStateNormal];
    [newCountBtn setImage:[UIImage imageNamed:@"new_account1.png"] forState:UIControlStateHighlighted];
    [newCountBtn setFrame:CGRectMake(self.view.frame.size.width/7, self.view.frame.size.height / 1.45, 238, 41)];
    [newCountBtn addTarget:self action:@selector(newCountBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newCountBtn];
    
}

- (void)faceBookBtnClicked
{
    _loginORsignController = [[DefaultSettingsViewController alloc] init];
    [self.navigationController pushViewController:_loginORsignController animated:YES];
}

- (void)newCountBtnClicked
{
    MySignUpViewController *signView= [[MySignUpViewController alloc] init];
    [self.navigationController pushViewController:signView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ibaction

//- (IBAction)showLeftSideBar:(id)sender
//{
//    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
//        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionLeft];
//    }
//}
//
//- (IBAction)showRightSideBar:(id)sender
//{
//    if ([[SidebarViewController share] respondsToSelector:@selector(showSideBarControllerWithDirection:)]) {
//        [[SidebarViewController share] showSideBarControllerWithDirection:SideBarShowDirectionRight];
//    }
//}



@end
