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

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation WaitListViewController


#pragma mark -
#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupConstaints];
    [self setupNavigationBar];
    
    _dataArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark - setup
- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:[self tableView]];
    [self.view addSubview:[self waitListOpenSlowView]];
}

- (void)setupConstaints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _waitListOpenSlotView);
    NSDictionary *metrics = @{@"openSlotHeight" : @(64)};
    
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
    return [_dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"%@-%d-%d", @"cellID", indexPath.section, indexPath.row];
    
    WaitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[WaitListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
