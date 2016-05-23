//
//  WaitListViewController.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListViewController.h"
#import "WaitListTableViewCell.h"

@interface WaitListViewController  ()

@end

@implementation WaitListViewController


#pragma mark -
#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupConstaints];
    [self setupNavigationBar];
}

#pragma mark -
#pragma mark - setup
- (void)setupView {
    [self.view addSubview:[self tableView]];
}

- (void)setupConstaints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _waitListOpenSlotView);
    NSDictionary *metrics = @{@"openSlotHeight" : @(45)};
    
    // setup vertical constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_waitListOpenSlotView(openSlotHeight)][_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    // setup horizontal constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_waitListOpenSlotView]|" options:0 metrics:metrics views:viewsDictionary]];
    
}

- (void)setupNavigationBar {
    
}



#pragma mark -
#pragma mark - UITableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark -
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - getter methods
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.tableFooterView = nil;
    }
    
    return _tableView;
}

- (WaitListOpenSlotView *)waitListOpenSlowView {
    if (!_waitListOpenSlotView) {
        _waitListOpenSlotView = [[WaitListOpenSlotView alloc] init];
        _waitListOpenSlotView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _waitListOpenSlotView.backgroundColor = [UIColor blueColor];
    }
    
    return _waitListOpenSlotView;
}

@end
