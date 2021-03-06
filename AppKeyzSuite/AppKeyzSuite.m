//
//  AppKeyzSuite.m
//  AppKeyz Sample Application
//
//  Created by Michael Hayes on 4/28/13.
//  Copyright (c) 2013 App Keyz. All rights reserved.
//

#import "AppKeyzSuite.h"

@implementation AppKeyzSuite
@synthesize viewController;

-(id) init
{
    return self;
}

+(void)setRegisterFields:(NSArray*)array
{
    [AppKeyz shared].registerFields = [NSArray arrayWithArray:array];
}


+(void)setupUserPlist
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:@"User.plist"];
    
    if ([NSDictionary dictionaryWithContentsOfFile:destinationPath]==nil) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"User.plist"];
        
        NSError *error = nil;
        if([[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error]){
            NSLog(@"File successfully copied");
        } else {
            NSLog(@"Error description-%@ \n", [error localizedDescription]);
            NSLog(@"Error reason-%@", [error localizedFailureReason]);
        }
        
    }
}

+(void)loadLoginScheme:(UIViewController*)vc
{
    //self.viewController = vc;
    if ([AKUser shared].isLoggedIn==false) {
        [AppKeyz shared].directRoute = none;
        AKiPhoneLandingVC* landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPhoneLandingVC" bundle:nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPadLandingVC" bundle:nil];
            
        }
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:landing];
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [vc presentModalViewController:navController animated:false];
    }
}

+(void)loginScreen:(UIViewController*)vc
{
    [AppKeyz shared].directRoute = directRouteLogin;
    AKiPhoneLandingVC* landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPhoneLandingVC" bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPadLandingVC" bundle:nil];
        
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:landing];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [vc presentModalViewController:navController animated:true];}

+(void)registerScreen:(UIViewController*)vc
{
    [AppKeyz shared].directRoute = directRouteRegister;
    AKiPhoneLandingVC* landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPhoneLandingVC" bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPadLandingVC" bundle:nil];
        
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:landing];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [vc presentModalViewController:navController animated:true];
}

+(void)editUser:(UIViewController*)vc
{
    [AppKeyz shared].directRoute = directRouteEditRegister;
    AKiPhoneLandingVC* landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPhoneLandingVC" bundle:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPadLandingVC" bundle:nil];
        
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:landing];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [vc presentModalViewController:navController animated:true];
}

+(void)logout:(UIViewController*)vc
{
    if ([AKUser shared].isLoggedIn==true) {
        [[AKUser shared] logout];
        [AppKeyz shared].directRoute = none;
        AKiPhoneLandingVC* landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPhoneLandingVC" bundle:nil];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            landing = [[AKiPhoneLandingVC alloc] initWithNibName:@"AKiPadLandingVC" bundle:nil];
            
        }
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:landing];
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [vc presentModalViewController:navController animated:true];

    }
}

+(void)loginRegAlertView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = window.rootViewController;
    
    RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"No Thanks" action:^{
        // this is the code that will be executed when the user taps "No"
        // this is optional... if you leave the action as nil, it won't do anything
        // but here, I'm showing a block just to show that you can use one if you want to.
    }];
    
    RIButtonItem *loginItem = [RIButtonItem itemWithLabel:@"Login In" action:^{
        // this is the code that will be executed when the user taps "Yes"
        // delete the object in question...
        [AppKeyzSuite loginScreen:vc];
    }];
    RIButtonItem *registerItem = [RIButtonItem itemWithLabel:@"Create Account" action:^{
        // this is the code that will be executed when the user taps "Yes"
        // delete the object in question...
        [AppKeyzSuite registerScreen:vc];
    }];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Without logging in, you will be unable to access your account, update your account of any purchases or access these purchases from other devices."
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:loginItem, registerItem, nil];
    [alertView show];
}

@end
