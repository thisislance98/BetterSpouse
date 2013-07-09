//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//

#import "DefaultSettingsViewController.h"
#import "PFGoodthingViewController.h"
#import "MySignUpViewController.h"
#import "PointsModel.h"
#import <Parse/PFQuery.h>
#import "PFAddSpouseViewController.h"
#import <FacebookSDK/FBSession.h>


@implementation DefaultSettingsViewController
@synthesize delegate;
#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"user_about_me", nil]];
        [logInViewController setFields: PFLogInFieldsFacebook | PFLogInFieldsDismissButton];
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }else{
        
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        PFQuery *rewardQuery = [PFQuery queryWithClassName:@"rewards"];
        [rewardQuery whereKey:@"userid" equalTo:username];
        [rewardQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (objects.count != 0) {
                    NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"rewards"];
                    PFObject *ps = dic[@"rewards"];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"rewards"] forKey:[NSString stringWithFormat:@"%@tempReward",[PFUser currentUser]]];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"rewardsNum"] forKey:[NSString stringWithFormat:@"%@tempRewardsNum",[PFUser currentUser]]];
                }
            }
        }];
        
        PFQuery *query = [PFQuery queryWithClassName:@"player"]; 
        [query whereKey:@"userid" equalTo:username]; 
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){ 
            if(!error){
                if (objects.count != 0) {
                    
                    NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"player"];
                    PFObject *ps = dic[@"player"];
//                    PointsModel *points = [[PointsModel alloc] init];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"task"] forKey:[NSString stringWithFormat:@"%@task",[PFUser currentUser]]];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"score"] forKey:[NSString stringWithFormat:@"%@score",[PFUser currentUser]]];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badtask"] forKey:[NSString stringWithFormat:@"%@badtask",[PFUser currentUser]]];
                    [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badscore"] forKey:[NSString stringWithFormat:@"%@badscore",[PFUser currentUser]]];
                    
                    
                    if (![[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@add",[PFUser currentUser]]]) {
                        PFAddSpouseViewController *addView = [[PFAddSpouseViewController alloc] init];
                        [self.navigationController pushViewController:addView animated:YES];
                    }else{
                        PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
                        [self.navigationController pushViewController:googView animated:YES];
                    }

//                    if (points) {
//                        points.taskArray = [ps objectForKey:@"task"];
//                        points.scoreArray = [ps objectForKey:@"score"];
//                        [delegate goodTableViewReload:points];
//                    }
                }
            }else{
                NSString *errorString = [[error userInfo]objectForKey:@"error"];
                NSLog(@"Error:%@",errorString);
            }
        }];
    }
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    PFObject *query = [PFObject objectWithClassName:@"player"];
    [query setObject:[PFUser currentUser].username forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] setObject:[PFUser currentUser].username forKey:@"user"];
    [query setObject:[PFUser currentUser].objectId forKey:@"object"];
    [query saveInBackground];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:[PFUser currentUser].username forKey:@"channels"];
    [currentInstallation saveInBackground];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
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
