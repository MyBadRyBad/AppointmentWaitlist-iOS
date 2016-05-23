//
//  WaitListViewController.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitListOpenSlotView.h"

@interface WaitListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WaitListOpenSlotView *waitListOpenSlotView;

@end
