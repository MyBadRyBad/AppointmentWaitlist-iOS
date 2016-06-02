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
#import <MBProgressHUD.h>

NSString *kAlertFailedTitle = @"Uh oh";
NSString *kAlertFailedMessage = @"Failed to fetch data: ";
NSString *kAlertNextStepMessage = @"Will load fake data for demo.";



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
    
    
    // attempt to pull data
    [BackendFunctions
     fetchAppointmentSlotsOfDays:kAppointmentFetchDefaultDayCount
     offset:kAppointmentFetchDefaultOffset
     providerId:kAppointmentFetchDefaultProviderID
     subdomain:kAppointmentFetchDefaultDomain
     timezone:kAppointmentFetchDefaultTimezone
     onCompletion:^(NSDictionary *dictionary, NSError *error) {
         if (error) {
             NSString *alertTitle = NSLocalizedString(kAlertFailedTitle, nil);
             NSString *alertMessage = [NSString stringWithFormat:@"%@%@", NSLocalizedString(kAlertFailedMessage, nil), error.localizedDescription];
             
             [self showAlertControllerWithTitle:alertTitle
                    message:alertMessage
                    action:^(UIAlertAction *action) {
                        NSString *alertTitle = NSLocalizedString(kAlertFailedTitle, nil);
                        NSString *alertMessage = NSLocalizedString(kAlertNextStepMessage, nil);
                                             
                        [self showAlertControllerWithTitle:alertTitle
                                message:alertMessage
                                action:^(UIAlertAction *action) {
                                    [self showWaitListViewControllerWithTimeArray:nil setAsTest:YES];
                                }];
            }];
            
             
         } else {
             NSMutableArray *timeArray = nil;
             id dictData = dictionary[kBackendWaitlistDataKey];
             
             if (dictData && [dictData isKindOfClass:[NSArray class]]) {
                 timeArray = [[NSMutableArray alloc] initWithArray:(NSArray *)dictData];
             }
             
             [self showWaitListViewControllerWithTimeArray:timeArray setAsTest:NO];
         }
         
     }];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark - show UIAlertController 
- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message action:(void (^)(UIAlertAction *action))action {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:action];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - pushWaitListViewController
- (void)showWaitListViewControllerWithTimeArray:(NSArray *)timeArray setAsTest:(BOOL)setAsTest{
    
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
    
    navigationWaitListController.tabBarItem =[[UITabBarItem alloc] initWithTitle:@""
                                                                           image:homeImage
                                                                   selectedImage:homeImageSelected];
    
    
    secondViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                    image:chatImage
                                                            selectedImage:chatImageSelected];
    
    thirdViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                                   image:settingsImage
                                                           selectedImage:settingsImageSelected];
    
    // adjust the tab bar icons down to center them
    navigationWaitListController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    secondViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    thirdViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    
    // set time availability array
    NSMutableArray *timeAvailableArray = (timeArray) ? [NSMutableArray arrayWithArray:timeArray] : nil;
    [waitListViewController setTimeAvailable:timeAvailableArray];
    [waitListViewController setAsTest:setAsTest];
    
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
