//
//  WaitListViewController.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+Utilities.h"
#import "BackendFunctions.h"
#import "kColorConstants.h"
#import "kBackendConstants.h"
#import "kConstants.h"
#import "WaitListTableViewCell.h"
#import "OpenSlotCollectionViewCell.h"

static NSString *const kCollectionCellIdentifier = @"ItemCellID";
static NSString *const kLoadingCollectionCellIdentifer = @"LoadingCellIdentifier";

static CGFloat const kCollectionViewHeight = 64.0f;

@interface WaitListViewController  ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

@property (nonatomic, assign) NSInteger currentCollectionViewIndex;
@property (nonatomic, assign) NSInteger selectedCollectionViewIndex;

@end

@implementation WaitListViewController


#pragma mark -
#pragma mark - View Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark - setup
- (void)setup {
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:kDateFormatStringJSON];
    
    _selectedCollectionViewIndex = 0;
    
    [self setupView];
    [self setupConstaints];
    [self setupNavigationBar];
    
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:[self tableView]];
    [self.view addSubview:[self collectionView]];
}

- (void)setupConstaints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _collectionView);
    NSDictionary *metrics = @{@"collectionViewHeight" : @(kCollectionViewHeight)};
    
    // setup vertical constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView(collectionViewHeight)][_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    // setup horizontal constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:metrics views:viewsDictionary]];
    
}

- (void)setupNavigationBar {
    
}



#pragma mark -
#pragma mark - UITableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];
    
    WaitListTableViewCell *selectedCell  = [_tableView cellForRowAtIndexPath:indexPath];
    WaitListTableViewCell *previousCell;
    WaitListTableViewCell *nextCell;
    
    // check to see if there are valid cells before and after selected
    if (indexPath.row - 1 >= 0) {
        NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
        previousCell = [_tableView cellForRowAtIndexPath:previousIndexPath];
    }
    
    if (indexPath.row + 1 < [timeArray count]) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
        nextCell = [_tableView cellForRowAtIndexPath:nextIndexPath];
    }
    
    
    if ([selectedCell isEnabled]) {
        [selectedCell setEnabled:NO];
        
        // disable circle view if previous cell is active
        if (previousCell && [previousCell isEnabled]) {
            [selectedCell setTopCircleViewVisible:YES];
            [previousCell setBottomCircleViewVisible:YES];
        } else if (previousCell && ![previousCell isEnabled]){
            [selectedCell setTopCircleViewVisible:NO];
            [previousCell setBottomCircleViewVisible:NO];
        }
        
        // show circle view for next cell if necesssary
        if (nextCell && [nextCell isEnabled]) {
            [selectedCell setBottomCircleViewVisible:YES];
            [nextCell setTopCircleViewVisible:YES];
        } else if (nextCell && ![nextCell isEnabled]) {
            [selectedCell setBottomCircleViewVisible:NO];
            [nextCell setTopCircleViewVisible:NO];
        }
        
    } else {
        [selectedCell setEnabled:YES];
        
        // show circle views for previous cell if necessary
        if (previousCell && [previousCell isEnabled]) {
            [selectedCell setTopCircleViewVisible:NO];
            [previousCell setBottomCircleViewVisible:NO];
        } else if (previousCell && ![previousCell isEnabled]) {
            [selectedCell setTopCircleViewVisible:YES];
            [previousCell setBottomCircleViewVisible:YES];
        }
        
        // show circle views for next cell if necessary
        if (nextCell && [nextCell isEnabled]) {
            [selectedCell setBottomCircleViewVisible:NO];
            [nextCell setTopCircleViewVisible:NO];
        } else if (nextCell && ![nextCell isEnabled]) {
            [selectedCell setBottomCircleViewVisible:YES];
            [nextCell setTopCircleViewVisible:YES];
        }
        
    }
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
    // add buffer cells for bottom and top of tableview
    
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];

    return [timeArray count];
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
#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataDictionary count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < [_dataDictionary count]) {
        
        // pre-fetch the next seven days
        if(indexPath.item == ([_dataDictionary count] - 7 + 1)){
            [self fetchMoreItems];
        }
        
        return [self openSlotCollectionCellForIndexPath:indexPath];
    }
    else {
        [self fetchMoreItems];
        return [self loadingCollectionCellForIndexPath:indexPath];
    }
}

- (OpenSlotCollectionViewCell *)openSlotCollectionCellForIndexPath:(NSIndexPath *)indexPath {
    
    OpenSlotCollectionViewCell *cell = (OpenSlotCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    
    [cell setCellAsSelected:(indexPath.item == _selectedCollectionViewIndex)];
    
    return cell;
}

- (UICollectionViewCell *)loadingCollectionCellForIndexPath:(NSIndexPath *)indexPath {
    
    OpenSlotCollectionViewCell *cell = (OpenSlotCollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:kLoadingCollectionCellIdentifer forIndexPath:indexPath];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center = cell.center;
    
    [cell addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    return cell;
}

- (void)fetchMoreItems {
    [self simulateFetch];
}

#pragma mark -
#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedCollectionViewIndex = indexPath.row;
    [_collectionView reloadData];
    [_tableView reloadData];
}

#pragma mark -
#pragma mark - generate test data
- (NSMutableArray *)createTestDataWithStartDay:(NSDate *)startDate {
    NSMutableArray *newTestTimeArray = [[NSMutableArray alloc] init];
    NSInteger numberOfHoursPerDay = 9;
    NSInteger minuteIncrement = 15;
    NSInteger totalNumberOfDays = 7;
    
    NSInteger minuteIncrementPerDay = numberOfHoursPerDay * (60 / minuteIncrement);
    
    // create a new date starting at 9:00am
    startDate = [[startDate dateAtStartOfDay] dateByAddingHours:9];
    
    for (int day = 0; day < totalNumberOfDays; day++) {
        
        // convert day into minutes
        unsigned int dayMinutes = (24 * 60) * day;
    
        // add beginning of the ay
        [newTestTimeArray addObject:[startDate dateByAddingDays:day]];
        
        // add increments of minuteIncrement until total hours reached
        for (int increment = 1; increment <= minuteIncrementPerDay; increment++) {
            
            [newTestTimeArray addObject:[startDate dateByAddingMinutes:(dayMinutes + (minuteIncrement * increment))]];
        }
    }
    
    return newTestTimeArray;
    
}

- (void)simulateFetch {
    NSMutableArray *newData = [NSMutableArray array];
    NSInteger loadSize = 7; // load next seven days
    for (int i = _currentCollectionViewIndex * loadSize; i < ((_currentCollectionViewIndex * loadSize) + loadSize); i++) {
        [newData addObject:[NSString stringWithFormat:@"Item #%d", i]];
    }
    
    _currentCollectionViewIndex++;
    
    
    // Simulate an async load...
    
    double delayInSeconds = 5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        // Add the new data to our local collection of data.
        for (int i = 0; i < newData.count; i++) {
         //   [_dataArray addObject:newData[i]];
        }
        
        // Tell the collectionView to reload.
        [self.collectionView reloadData];
        
    });
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [_dataDictionary removeAllObjects];
    
    _dataDictionary = nil;
    _keyArray = nil;
    
    [BackendFunctions
     fetchAppointmentSlotsOfDays:kAppointmentFetchDefaultDayCount
     offset:kAppointmentFetchDefaultOffset
     providerId:kAppointmentFetchDefaultProviderID
     subdomain:kAppointmentFetchDefaultDomain
     timezone:kAppointmentFetchDefaultTimezone
     onCompletion:^(NSDictionary *dictionary, NSError *error) {
         NSMutableArray *timeArray = nil;
         id dictData = dictionary[kBackendWaitlistDataKey];
         
         if (dictData && [dictData isKindOfClass:[NSArray class]]) {
             timeArray = [[NSMutableArray alloc] initWithArray:(NSArray *)dictData];
         }
         
         [self setTimeAvailable:timeArray];
         [_tableView reloadData];
         [_collectionView reloadData];
         
    }];
}

#pragma mark -
#pragma mark - setter methods
- (void)setTimeAvailable:(NSMutableArray *)timeAvailableArray {
    
    if (!timeAvailableArray || [timeAvailableArray count] == 0) {
        timeAvailableArray = [self createTestDataWithStartDay:[NSDate date]];
    }
    
    if (!_dataDictionary || [_dataDictionary isEqual:[NSNull null]]) {
        _dataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    for (int index = 0; index < [timeAvailableArray count]; index++) {
        NSDate *date;
        
        // check what kind of objects are in the string
        if ([timeAvailableArray[index] isKindOfClass:[NSDate class]]) { // is date
            date = timeAvailableArray[index];
        } else { // is string
            NSString *jsonString = timeAvailableArray[index];
            date = [_dateFormatter dateFromString:jsonString];
        }
        
        // add the date to the data dictionary
        NSString *key = [date shortDateString];
        NSMutableArray *timeArray = [_dataDictionary objectForKey:key];
        
        if (!timeArray || [timeArray isEqual:[NSNull null]]) {
            timeArray = [[NSMutableArray alloc] init];
            [_dataDictionary setObject:timeArray forKey:key];
        }
        
        [timeArray addObject:date];
    }
    
    _keyArray = [self getSortedDateKeyArrayFromDateDictionary:_dataDictionary];
}

- (NSArray *)getSortedDateKeyArrayFromDateDictionary:(NSDictionary *)dateDictionary {
    if (dateDictionary) {
        // get a sorted reference of the keys
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        NSArray *tempKeyArray = [_dataDictionary allKeys];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSMutableArray *sortedKeyArray = [[NSMutableArray alloc] init];
        
        // enumerate through the temp keys and convert to nsdate
        for (NSString *key in tempKeyArray) {
            [tempArray addObject:[formatter dateFromString:key]];
        }
        
        [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [(NSDate *)obj1 compare:(NSDate *)obj2];
        }];
        
        for (NSDate *keyDate in tempArray) {
            [sortedKeyArray addObject:[formatter stringFromDate:keyDate]];
        }
        
        // get sorted array
        return  [NSArray arrayWithArray:sortedKeyArray];
    } else {
        return nil;
    }
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // setup flowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kCollectionViewHeight + 4, kCollectionViewHeight);;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_collectionView registerClass:[OpenSlotCollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLoadingCollectionCellIdentifer];
        _collectionView.pagingEnabled = NO;
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor grayColor];
        
        // add shadow
        _collectionView.layer.masksToBounds = NO;
        _collectionView.layer.shadowOffset = CGSizeMake(-1, 0.5);
        _collectionView.layer.shadowRadius = 3;
        _collectionView.layer.shadowOpacity = 0.5;
    }
    
    return _collectionView;
}

@end
