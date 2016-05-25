//
//  RootViewController.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "RootViewController.h"
#import "WaitListViewController.h"
#import "BackendFunctions.h"
#import "kBackendConstants.h"
#import "kConstants.h"
#import <IonIcons.h>


@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [BackendFunctions getAppointmentSlotsOfDays:7 offset:0 providerId:1 subdomain:@"test" timezone:@"America/New_York" onCompletion:^(NSDictionary *dictionary, NSError *error) {
        
        if (error) {
            [self showWaitListViewController];
        } else {
            [self showWaitListViewController];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - 
#pragma mark - pushWaitListViewController 
- (void)showWaitListViewController {
    
    WaitListViewController *waitListViewController = [[WaitListViewController alloc] init];
    UIViewController *secondViewController = [[UIViewController alloc] init];
    UIViewController *thirdViewController = [[UIViewController alloc] init];
    
    UINavigationController *navigationWaitListController = [[UINavigationController alloc] initWithRootViewController:waitListViewController];
    
    
    // initialize tab bar images
    UIImage *homeImageSelected = [IonIcons imageWithIcon:ion_android_home size:30.0f color:[UIColor whiteColor]];
    UIImage *chatImageSelected = [IonIcons imageWithIcon:ion_android_chat size:30.0f color:[UIColor whiteColor]];
    UIImage *settingsImageSelected = [IonIcons imageWithIcon:ion_android_settings size:30.0f color:[UIColor whiteColor]];
    
    UIImage *homeImage = [IonIcons imageWithIcon:ion_android_home size:30.0f color:[UIColor whiteColor]];
    UIImage *chatImage = [IonIcons imageWithIcon:ion_android_chat size:30.0f color:[UIColor whiteColor]];
    UIImage *settingsImage = [IonIcons imageWithIcon:ion_android_settings size:30.0f color:[UIColor whiteColor]];
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] initWithObjects:navigationWaitListController, secondViewController, thirdViewController, nil];
    
    // setup tab bar and tabBarItems
    [tabBarController setViewControllers:tabViewControllers];
    
    navigationWaitListController.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"" image:homeImage selectedImage:homeImageSelected];
    
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:chatImage selectedImage:chatImageSelected];
    
    thirdViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:settingsImage selectedImage:settingsImageSelected];
    
    
    // setup navigation bar
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
