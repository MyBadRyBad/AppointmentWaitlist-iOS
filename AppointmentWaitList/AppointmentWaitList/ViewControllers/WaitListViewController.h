//
//  WaitListViewController.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;


// setters
- (void)setTimeAvailableArray:(NSMutableArray *)timeAvailableArray;

@end
