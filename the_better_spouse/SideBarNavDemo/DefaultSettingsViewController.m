//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//

#import "DefaultSettingsViewController.h"
#import "PFGoodthingViewController.h"
#import "MySignUpViewController.h"
#import <Parse/PFQuery.h>

@implementation DefaultSettingsViewController

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
        PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
        [self.navigationController pushViewController:googView animated:YES];
        
        PFQuery *query = [PFQuery queryWithClassName:@"player"]; //1
        
//        [query getObjectInBackgroundWithId:[NSString stringWithFormat:@"%@",[PFUser currentUser]] block:^(PFObject *player, NSError *error) {
//            // Do something with the returned PFObject in the gameScore variable.
//            NSLog(@"%@", player);
//            NSMutableArray *array = [NSMutableArray arrayWithArray:[player objectForKey:@"task"]];
//            NSLog(@"task:%@",array);
//        }];
        
        [query whereKey:@"username" equalTo:[PFUser currentUser]]; //2
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){ //4
            if(!error){
                NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"User"];
                PFObject *ps = dic[@"User"];
                NSArray *array = [NSArray arrayWithArray:[ps objectForKey:@"task"]];
                NSArray *array1 = [NSArray arrayWithArray:[ps objectForKey:@"score"]];
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
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
    [self.navigationController pushViewController:googView animated:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"User"]; //1
    [query whereKey:@"username" equalTo:[PFUser currentUser]]; //2
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){ //4
        if(!error){
            NSLog(@"Successfully retrieved: %@",objects);
        }else{
            
            NSString *errorString = [[error userInfo]objectForKey:@"error"];
            NSLog(@"Error:%@",errorString);
        }
        
    }];
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
