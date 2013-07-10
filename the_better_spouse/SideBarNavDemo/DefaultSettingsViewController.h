//
//  DefaultSettingsViewController.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//
#import "PointsModel.h"

@protocol downloadDataForReload <NSObject>

- (void) goodTableViewReload:(PointsModel *)data;

@end

@interface DefaultSettingsViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (nonatomic, assign) id<downloadDataForReload>delegate;
@property (nonatomic, assign) NSString *tempString;
@end
