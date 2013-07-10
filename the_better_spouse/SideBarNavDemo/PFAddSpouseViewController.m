//
//  PFAddSpouseViewController.m
//  the_better_spouse
//
//  Created by chenxin on 13-6-20.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "PFAddSpouseViewController.h"
#import "PFGoodthingViewController.h"

@interface PFAddSpouseViewController ()

@end

@implementation PFAddSpouseViewController

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
    
    UIImage *image = [UIImage imageNamed:@"add_spouseBG01.png"];
    UIImageView *addView = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:14 topCapHeight:21]];
    addView.Frame = CGRectMake(0, 0, addView.image.size.width, self.view.frame.size.height);
    [self.view addSubview:addView];
    
    spouseInfo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_spouse_form.png"]];
    spouseInfo.backgroundColor = [UIColor clearColor];
    spouseInfo.frame = CGRectMake(20,self.view.frame.size.height - 180, 281, 95);
    spouseInfo.userInteractionEnabled = YES;
    [self.view addSubview:spouseInfo];
    
    _userText = [[UITextField alloc] initWithFrame:CGRectMake(93, 2, spouseInfo.frame.size.width - 95, spouseInfo.frame.size.height / 4)];
    [_userText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _userText.returnKeyType = UIReturnKeyDone;
    _userText.backgroundColor = [UIColor clearColor];
    _userText.delegate = self;
    _userText.tag = 1;
    [spouseInfo addSubview:_userText];
    
    _emailText = [[UITextField alloc] initWithFrame:CGRectMake(93, 71, spouseInfo.frame.size.width - 95, spouseInfo.frame.size.height / 4)];
    _emailText.backgroundColor = [UIColor clearColor];
    [_emailText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _emailText.returnKeyType = UIReturnKeyDone;
    _emailText.delegate = self;
    _emailText.tag = 2;
    [spouseInfo addSubview:_emailText];
    
    UIButton *addSpouseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addSpouseBtn setImage:[UIImage imageNamed:@"add_spouseBtn.png"] forState:UIControlStateNormal];
    [addSpouseBtn setImage:[UIImage imageNamed:@"add_spouseBtn2.png"] forState:UIControlStateHighlighted];
    [addSpouseBtn setFrame:CGRectMake(46, self.view.frame.size.height - 60, 237, 51)];
    [addSpouseBtn addTarget:self action:@selector(addSpouseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSpouseBtn];
    
}

- (void)showMeLaterClicked
{
    PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
    [self.navigationController pushViewController:googView animated:YES];
}

- (void)addSpouseBtnClicked
{
    if (_userText.text .length > 0 || _userText.text.length > 0) {
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        PFQuery *query = [PFQuery queryWithClassName:@"player"];
        [query whereKeyExists:@"userid"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            for (int i = 0; i < objects.count; i++) {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects objectAtIndex:i] forKey:@"player"];
                PFObject *ps = dic[@"player"];
                [array addObject:[ps objectForKey:@"userid"]];
            }
        }];
        
        if (_userText.text.length > 0) {
            if ([array containsObject:_userText.text]) {
                [query whereKey:@"userid" equalTo:_userText.text];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){ //4
                    if(!error){
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@add",[PFUser currentUser]]];
                        [[NSUserDefaults standardUserDefaults] setObject:_userText.text forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
                        [PFPush sendPushMessageToChannelInBackground:_userText.text withMessage:[NSString stringWithFormat:@"%@ Add you as a friend",[PFUser currentUser].username]];
                        
                        if (objects.count != 0) {
                            NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"player"];
                            PFObject *ps = dic[@"player"];
                            NSString *spouseName = [ps objectForKey:@"object"];
                            [[NSUserDefaults standardUserDefaults] setObject:spouseName forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
                            [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"task"] forKey:[NSString stringWithFormat:@"%@task",spouseName]];
                            [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"score"] forKey:[NSString stringWithFormat:@"%@score",spouseName]];
                            [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badtask"] forKey:[NSString stringWithFormat:@"%@badtask",spouseName]];
                            [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badscore"] forKey:[NSString stringWithFormat:@"%@badscore",spouseName]];
                        }
                    }
                }];
            }else{
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Index error" message:@"the name is invaliud" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertview show];
            }
        }
        
        if (_emailText.text.length > 0) {
           if ([array containsObject:_userText.text]) {
               NSRange range = [_emailText.text rangeOfString:@"@"];
            if (range.length > 0) {
                tempString = [_emailText.text substringToIndex:range.location];
                NSLog(@"message:%@",tempString);
                if (tempString != nil && tempString.length > 0) {
                    [query whereKey:@"userid" equalTo:_emailText.text];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){ //4
                        if(!error){
                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@add",[PFUser currentUser]]];
                            [[NSUserDefaults standardUserDefaults] setObject:tempString forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
                            [PFPush sendPushMessageToChannelInBackground:[NSString stringWithFormat:@"tbs%@",tempString] withMessage:[NSString stringWithFormat:@"%@ Add you as a friend",_emailText.text]];
                            
                            if (objects.count != 0) {
                                NSDictionary *dic = [NSDictionary dictionaryWithObject:[objects lastObject] forKey:@"player"];
                                PFObject *ps = dic[@"player"];
                                NSString *spouseName = [ps objectForKey:@"object"];
                                [[NSUserDefaults standardUserDefaults] setObject:spouseName forKey:[NSString stringWithFormat:@"%@spouse",[PFUser currentUser]]];
                                [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"task"] forKey:[NSString stringWithFormat:@"%@task",spouseName]];
                                [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"score"] forKey:[NSString stringWithFormat:@"%@score",spouseName]];
                                [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badtask"] forKey:[NSString stringWithFormat:@"%@badtask",spouseName]];
                                [[NSUserDefaults standardUserDefaults] setObject:[ps objectForKey:@"badscore"] forKey:[NSString stringWithFormat:@"%@badscore",spouseName]];
                            }
                        }
                    }];
                }
            }
           }else{
               UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Index error" message:@"the email is invaliud" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               [alertview show];
           }
        }
    }
    PFGoodthingViewController *googView = [[PFGoodthingViewController alloc] init];
    [self.navigationController pushViewController:googView animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    self.view.frame = CGRectMake(0, -180 , self.view.frame.size.width, self.view.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
