//
//  AppDelegate.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "AppDelegate.h"
#import "SidebarViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate
@synthesize delegate;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    // NSString *notificationPayload = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    [Parse setApplicationId:@"GC8Zbs9bF8k7O1GUrLPf3tZUJXlNjrCV2FYpjtEK"
                  clientKey:@"yPc5QFaUttLncyyhgSIxusL49M6cBGgklRBhk599"];
    
    [PFFacebookUtils initializeFacebook];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    //    App ID/API Key
    //    374120159366168
    //    App Secret
    //    f82f121a4354523f4f4542b44d8e52c1
    //    Sandbox Mode
    //    开
    //    Listed Platforms
    //    Website with Facebook Login， App on Facebook
    
    // Override point for customization after application launch.
    
    self.viewController = [[SidebarViewController alloc] initWithNibName:@"SidebarViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    NSLog(@"message:%@",message);
    
    NSRange lostRange = [message rangeOfString:@"-"];
    NSRange getRange = [message rangeOfString:@"get"];
    NSRange addRange = [message rangeOfString:@"Add"];
    //       if (application.applicationState == UIApplicationStateActive) {
    
    if (lostRange.length > 0) {
        NSString *temp = [message substringFromIndex:lostRange.location+1];
        NSString *lostnumber = [temp substringToIndex:1];
        NSLog(@"message:%@",lostnumber);
        [delegate changeThemTextfieldNumber:lostnumber];
    }
    
    if (getRange.length >0 ) {
        NSString *temp = [message substringFromIndex:getRange.location+4];
        NSString *getnumber = [temp substringToIndex:1];
        NSLog(@"message:%@",getnumber);
        [delegate changeYouTextfieldNumber:getnumber];
    }
    
//    if (addRange.length > 0) {
//        NSString *addnumber = [message substringToIndex:addRange.location-1];
//        NSString *spouseName = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
//        if (spouseName == nil) {
//            NSRange range = [addnumber rangeOfString:@"@"];
//            if (range.location > 0 && range.location < 100) {
//                NSString *tempString = [addnumber substringToIndex:range.location];
//                if (tempString != nil && tempString.length > 0) {
//                    [PFPush sendPushMessageToChannelInBackground:[NSString stringWithFormat:@"tbs%@",tempString] withMessage:[NSString stringWithFormat:@"%@ Add you as a friend",addnumber]];
//                    [[NSUserDefaults standardUserDefaults] setObject:tempString forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
//                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@add",[PFUser currentUser]]];
//                }
//            }else{
//                [PFPush sendPushMessageToChannelInBackground:addnumber withMessage:[NSString stringWithFormat:@"%@ Add you as a friend",[PFUser currentUser].username]];
//                [[NSUserDefaults standardUserDefaults] setObject:addnumber forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
//                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@add",[PFUser currentUser]]];
//            }
//        }
//    }else{
//        
//    }
    
    //    } else {
    //        // The application was just brought from the background to the foreground,
    //        // so we consider the app as having been "opened by a push notification."
    //        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    //    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // ... other Parse setup logic here
    [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:[aNotification userInfo]];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationMaskLandscape);
}

//for iOS6
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
