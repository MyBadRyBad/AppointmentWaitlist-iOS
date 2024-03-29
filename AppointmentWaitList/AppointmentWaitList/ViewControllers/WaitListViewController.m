//
//  WaitListViewController.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <IonIcons.h>
#import "ActionButton.h"
#import "HelperFile.h"
#import "NSDate+Helper.h"
#import "NSDate+Utilities.h"
#import "BackendFunctions.h"
#import "kColorConstants.h"
#import "kBackendConstants.h"
#import "kConstants.h"
#import "WaitListTableViewCell.h"
#import "OpenSlotCollectionViewCell.h"

static NSString *const kCollectionCellIdentifier = @"ItemCellID";
static NSString *const kLoadingCollectionCellIdentifer = @"LoadingCellIdentifier";

static NSString *const kNavigationTitle = @"Select a waitlist time range";

static CGFloat const kCollectionViewHeight = 64.0f;
static CGFloat const kActionButtonHeight = 44.0f;

@interface WaitListViewController  ()

@property (nonatomic, strong) ActionButton *actionButton;

@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) NSMutableArray *selectedRowArray;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;

@property (nonatomic, assign) NSInteger fetchOffset;
@property (nonatomic, assign) NSInteger currentCollectionViewIndex;
@property (nonatomic, assign) NSInteger selectedCollectionViewIndex;
@property (nonatomic, assign) BOOL isTest;

// constraints for actionbutton
@property (nonatomic, strong) NSLayoutConstraint *verticalConstraintActionButton;

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
    _selectedCollectionViewIndex = 0;
    _fetchOffset = 0;
    [self resetSelectedTableViewRows];
    
    [self setupView];
    [self setupConstaints];
    [self setupNavigationBar];
    
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    // add separatorView for background
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImageTimeAreaWidth, self.view.frame.size.height)];
    separatorView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:separatorView];
    
    
    [self.view addSubview:[self tableView]];
    [self.view addSubview:[self collectionView]];
    [self.view addSubview:[self actionButton]];
    
    // just in case, send subview to back
    [self.view sendSubviewToBack:separatorView];
    _actionButton.hidden = YES;
}

- (void)setupConstaints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _collectionView, _actionButton);
    NSDictionary *metrics = @{@"collectionViewHeight" : @(kCollectionViewHeight),
                              @"actionButtonHeight" : @(kActionButtonHeight)};
    
    // setup vertical constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView(collectionViewHeight)][_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_actionButton(actionButtonHeight)]" options:0 metrics:metrics views:viewsDictionary]];
    
    _verticalConstraintActionButton = [NSLayoutConstraint constraintWithItem:_actionButton
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:kActionButtonHeight];
    
    [self.view addConstraint:_verticalConstraintActionButton];
    
    // setup horizontal constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_actionButton]|" options:0 metrics:metrics views:viewsDictionary]];
    
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    // set up navigation Bar
    self.navigationItem.title = NSLocalizedString(kNavigationTitle, nil);
    NSShadow *shadow = [[NSShadow alloc] init];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithWhite:1.0f alpha:1.0f], NSForegroundColorAttributeName,
      shadow,NSShadowAttributeName,
      shadow, NSShadowAttributeName,
      [UIFont systemFontOfSize:kFontSizeNavigationBar], NSFontAttributeName,
      nil]];
    
    
    // initialize back button
    UIImage *image = [IonIcons imageWithIcon:ion_arrow_left_c size:kImageSizeArrow color:[kColorConstants navigationBarBackArrowColor:1.0f]];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(didPressBackButton:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.navigationController.navigationBar setBarTintColor:[kColorConstants navigationBarColor:1.0f]];
    [self.navigationController.navigationBar setTintColor:[kColorConstants navigationBarColor:1.0f]];
}


#pragma mark -
#pragma mark - navigationBar
- (void)didPressBackButton:(id)selector {
    // do nothing
}


#pragma mark -
#pragma mark - UITableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // only allow middle cells. ignore the top + bottom buffer cells
    if (indexPath.row > 0 && indexPath.row < [_selectedRowArray count]) {
        NSNumber *isSelected = (NSNumber *)_selectedRowArray[indexPath.row - 1];
        _selectedRowArray[indexPath.row - 1] = [NSNumber numberWithBool:![isSelected boolValue]];
        
        // show actionButton if is hidden and user has a row selected
        if (_actionButton.isHidden && [_selectedRowArray containsObject:@(YES)]) {
            [self showActionButton:YES isAnimated:YES];
        }
        // hide actionButton if is shown and there are no longer any selected rows
        else if (!_actionButton.isHidden && ![_selectedRowArray containsObject:@(YES)]) {
            [self showActionButton:NO isAnimated:YES];
        }
        
        [_tableView reloadData];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];
    
    return (indexPath.row == [timeArray count]) ? 50.0f : 36.0f;
}
#pragma mark -
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // add buffer cells for bottom and top of tableview
    
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];

    // add a buffer of two empty rows for visual purposes
    return [timeArray count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString stringWithFormat:@"%@-%d-%d", @"cellID", indexPath.section, indexPath.row];
    
    WaitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[WaitListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self setupWaitListTableViewCell:cell indexPath:indexPath];
    
    return cell;
}

- (void)setupWaitListTableViewCell:(WaitListTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSInteger currentCellIndex = indexPath.row - 1;
    NSInteger previousCellIndex = currentCellIndex - 1;
    NSInteger nextCellIndex = currentCellIndex + 1;
    
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];
    
    
    // top buffer cell
    if (indexPath.row == 0) {
        NSDate *date = timeArray[indexPath.row];
        cell.bottomTimeLabel.text = [date stringWithFormat:kDateFormatTime];
        cell.bottomAmpmLabel.text = [date stringWithFormat:@"a"];
        
        if (nextCellIndex < [_keyArray count]) {
            BOOL enabled = [(NSNumber *)_selectedRowArray[nextCellIndex] boolValue];
            cell.bottomTimeLabel.textColor = [kColorConstants waitListTextColorSelected:enabled alpha:1.0f];
            [cell setBottomCircleViewVisible:enabled];
        }
    }
    
    // bottom buffer cell
    if (indexPath.row == [timeArray count]) {
        cell.lineSeparatorView.hidden = YES;
    }
    
    
    // content cells
    if (indexPath.row > 0 && indexPath.row < [timeArray count]) {
        NSDate *currentDate = timeArray[currentCellIndex];
        NSDate *nextDate = timeArray[currentCellIndex + 1];
        
        // setup time labels
        cell.topTimeLabel.text = [currentDate stringWithFormat:kDateFormatTime];
        cell.bottomTimeLabel.text = [nextDate stringWithFormat:kDateFormatTime];
        
        // display AM/PM for first cell
        if (indexPath.row == 1) {
            cell.topAmpmLabel.text = [currentDate stringWithFormat:@"a"];
        } else { // display PM only if previous cell was in AM
            
            NSDate *previousDate = timeArray[currentCellIndex - 1];
            NSString *previousAmpmText = [previousDate stringWithFormat:@"a"];
            NSString *currentAmpmText = [currentDate stringWithFormat:@"a"];
            NSString *nextAmPmText = [nextDate stringWithFormat:@"a"];
            
            if (![currentAmpmText isEqualToString:previousAmpmText]) {
                cell.topAmpmLabel.text = currentAmpmText;
            }
            
            if (![currentAmpmText isEqualToString:nextAmPmText]) {
                cell.bottomAmpmLabel.text = nextAmPmText;
            }
            
        }
        
        // now check for cell selection
        BOOL currentCellSelected = [(NSNumber *)_selectedRowArray[indexPath.row - 1] boolValue];
        [cell setEnabled:currentCellSelected];
        
        // Hide/Show bottom circle view if previous cell is selected/not selected
        if (previousCellIndex >= 0) {
            BOOL previousCellSelected = [(NSNumber *)_selectedRowArray[previousCellIndex] boolValue];
            BOOL topCircleVisible = (!previousCellSelected && currentCellSelected) || (previousCellSelected && !currentCellSelected);
            
            [cell setTopCircleViewVisible:topCircleVisible];
        } else { // is first content cell
            [cell setTopCircleViewVisible:currentCellSelected];
        }
        
        // Hide/Show top circle view if next cell is selected/not selected
        if (nextCellIndex < [_selectedRowArray count]) {
            BOOL nextCellSelected = [(NSNumber *)_selectedRowArray[nextCellIndex] boolValue];
            BOOL bottomCircleVisible = (!nextCellSelected && currentCellSelected) || (nextCellSelected && !currentCellSelected);
            
            [cell setBottomCircleViewVisible:bottomCircleVisible];
            [cell highlightLineSeparator:bottomCircleVisible];
        }
    } else if (indexPath.row == 0 && nextCellIndex < [_selectedRowArray count]) { // is top buffer cell
        BOOL nextCellSelected = [(NSNumber *)_selectedRowArray[nextCellIndex] boolValue];
        [cell setBottomCircleViewVisible:nextCellSelected];
        [cell highlightLineSeparator:nextCellSelected];
    }
}


#pragma mark -
#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // + 1 to trigger fetch
    return [_dataDictionary count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < [_dataDictionary count]) {
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
    
    NSString *dateString = _keyArray[indexPath.row];
    NSDate *cellDate = [NSDate dateFromString:dateString withFormat:kDateFormatShortStyle];
    
    // check if the cell is today, and show today label
    if ([dateString isEqualToString:[[NSDate date] stringWithFormat:kDateFormatShortStyle]]) {
        [cell setCellAsToday:YES];
        
    } else { // not today
        cell.dayNameLabel.text = [[cellDate stringWithFormat:kDateFormatShortDayName] uppercaseString];
        cell.dayNumberLabel.text = [cellDate stringWithFormat:kDateFormatDayNumber];
        cell.monthLabel.text = [cellDate stringWithFormat:kDateFormatLongMonth];
        [cell setCellAsToday:NO];
    }
    
    return cell;
}

- (UICollectionViewCell *)loadingCollectionCellForIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:kLoadingCollectionCellIdentifer forIndexPath:indexPath];
    
    cell.backgroundColor = [kColorConstants openSlotDayViewBackgroundColotNotSelected:1.0f];
    
    // add activity indicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityIndicator setColor:[kColorConstants openSlotDayViewBackgroundColorSelected:1.0f]];
    activityIndicator.center = cell.contentView.center;
    
    [cell.contentView addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // only call if index is not currently selected
    if (_selectedCollectionViewIndex != indexPath.row) {
        _selectedCollectionViewIndex = indexPath.row;
        
        [self resetSelectedTableViewRows];
        [self showActionButton:NO isAnimated:YES];
        [_collectionView reloadData];
        [_tableView reloadData];
    }
}


#pragma mark -
#pragma mark - fetch Items
- (void)fetchMoreItems {
    
    if (_isTest) {
        _fetchOffset = _fetchOffset + 7;
        [self simulateFetch];
    } else {
        [BackendFunctions
         fetchAppointmentSlotsOfDays:kAppointmentFetchDefaultDayCount
         offset:(kAppointmentFetchDefaultOffset + 7)
         providerId:kAppointmentFetchDefaultProviderID
         subdomain:kAppointmentFetchDefaultDomain
         timezone:kAppointmentFetchDefaultTimezone
         onCompletion:^(NSDictionary *dictionary, NSError *error) {
             if (error) {
                 NSString *title = NSLocalizedString(@"Uh oh", nil);
                 NSString *message = NSLocalizedString(@"Error", nil);
                 
                 
                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"%@: %@", message, error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil];
                 
                 [alertController addAction:okAction];
                 
                 [self presentViewController:alertController animated:YES completion:nil];
                 
             } else {
                 
                 // first set the offset, so that next pull will be 7 next days
                 _fetchOffset = _fetchOffset + 7;
                 
                 // get time array from dict and set the time available
                 NSMutableArray *timeArray = nil;
                 id dictData = dictionary[kBackendWaitlistDataKey];
                 
                 if (dictData && [dictData isKindOfClass:[NSArray class]]) {
                     timeArray = [[NSMutableArray alloc] initWithArray:(NSArray *)dictData];
                 }
                 
                 [self setTimeAvailable:timeArray];
                 
             }
         }];
    }
    

}

#pragma mark -
#pragma mark - reset selectedRows 
- (void)resetSelectedTableViewRows {
    NSString *key = _keyArray[_selectedCollectionViewIndex];
    NSArray *timeArray = _dataDictionary[key];
    
    _selectedRowArray = nil;
    _selectedRowArray = [[NSMutableArray alloc] initWithCapacity:[timeArray count]];
    
    for (int index = 0; index <[timeArray count]; index++) {
        [_selectedRowArray addObject:[NSNumber numberWithBool:NO]];
    }
}

#pragma mark -
#pragma mark - show/hide actionButton
- (void)showActionButton:(BOOL)showActionButton isAnimated:(BOOL)isAnimated {
    if (showActionButton) {
        _verticalConstraintActionButton.constant = 0;
        _actionButton.hidden = NO;
        
        if (isAnimated) {
            [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
                [self.view layoutIfNeeded];
            } completion:nil];
        } else {
            [self.view layoutIfNeeded];
        }
    } else {
        _verticalConstraintActionButton.constant = kActionButtonHeight;
        
        if (isAnimated) {
            [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                _actionButton.hidden = YES;
            }];
        } else {
            [self.view layoutIfNeeded];
        }
    }
}
#pragma mark -
#pragma mark - generate test data
- (void)setAsTest:(BOOL)setAsTest {
    _isTest = setAsTest;
    
    // if there is existing data, clear it and create tests or pull for server
    if ([_dataDictionary count] > 0) {
        [_dataDictionary removeAllObjects];
        _dataDictionary = nil;
        _keyArray = nil;
        _selectedRowArray = nil;
        _dataDictionary = [[NSMutableDictionary alloc] init];
        
        if (setAsTest) {
            [self setTimeAvailable:nil];
        } else {
            [BackendFunctions
             fetchAppointmentSlotsOfDays:kAppointmentFetchDefaultDayCount
             offset:(kAppointmentFetchDefaultOffset + 7)
             providerId:kAppointmentFetchDefaultProviderID
             subdomain:kAppointmentFetchDefaultDomain
             timezone:kAppointmentFetchDefaultTimezone
             onCompletion:^(NSDictionary *dictionary, NSError *error) {
                 if (error) {
                     NSString *title = NSLocalizedString(@"Uh oh", nil);
                     NSString *message = NSLocalizedString(@"Error", nil);
                     
                     
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"%@: %@", message, error.localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:nil];
                     
                     [alertController addAction:okAction];
                     
                     [self presentViewController:alertController animated:YES completion:nil];
                     
                 } else {
                     NSMutableArray *timeArray = nil;
                     id dictData = dictionary[kBackendWaitlistDataKey];
                     
                     if (dictData && [dictData isKindOfClass:[NSArray class]]) {
                         timeArray = [[NSMutableArray alloc] initWithArray:(NSArray *)dictData];
                     }
                     
                     [self setTimeAvailable:timeArray];
                 }
             }];
        }
    }
}

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
    // Simulate an async load...
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        // create new seven days
        NSDate *nextSevenDate = [[NSDate date] dateByAddingDays:_fetchOffset];
        NSMutableArray *newDaysArray = [self createTestDataWithStartDay:nextSevenDate];
        [self setTimeAvailable:newDaysArray];
        
        // Tell the collectionView to reload.
        [_collectionView reloadData];
        
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
    // create test data only when recieving nil
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
            date = [NSDate dateFromString:jsonString];
        }
        
        // add the date to the data dictionary
        NSString *key = [date stringWithFormat:kDateFormatShortStyle];
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
        NSArray *tempKeyArray = [_dataDictionary allKeys];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        NSMutableArray *sortedKeyArray = [[NSMutableArray alloc] init];
        
        // enumerate through the temp keys and convert to nsdate
        for (NSString *key in tempKeyArray) {
            [tempArray addObject:[NSDate dateFromString:key withFormat:kDateFormatShortStyle]];
        }
        
        [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [(NSDate *)obj1 compare:(NSDate *)obj2];
        }];
        
        for (NSDate *keyDate in tempArray) {
            [sortedKeyArray addObject:[keyDate stringWithFormat:kDateFormatShortStyle]];
        }
        
        // get sorted array
        return  [NSArray arrayWithArray:sortedKeyArray];
    } else {
        return nil;
    }
}

#pragma mark -
#pragma mark - getter methods
- (ActionButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [[ActionButton alloc] init];
        _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
        _actionButton.backgroundColor = [kColorConstants actionButtonBackgroundColor:1.0f];
        
        
        // setup background color
        UIImage *backgroundImage = [HelperFile imageWithColor:[kColorConstants actionButtonBackgroundColor:1.0f]];
        UIImage *backgroundImageHighlighted = [HelperFile imageWithColor:[kColorConstants actionButtonBackgroundColorHighlighted:1.0f]];
        
        [_actionButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_actionButton setBackgroundImage:backgroundImageHighlighted forState:UIControlStateHighlighted];
        
        // setup label and icon image
        _actionButton.nameLabel.text = NSLocalizedString(@"Add me to waitlist", nil);
        _actionButton.nameLabel.textColor = [UIColor whiteColor];
        _actionButton.nameLabel.textAlignment = NSTextAlignmentRight;
        
        UIImage *arrowImage = [IonIcons imageWithIcon:ion_arrow_right_c size:kImageSizeArrow color:[UIColor whiteColor]];
        _actionButton.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _actionButton.iconImageView.image = arrowImage;
        
    }
    
    return _actionButton;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        CGRect backgroundViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        CGRect separatorViewFrame = CGRectMake(0, 0, kImageTimeAreaWidth, self.view.frame.size.height);
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:backgroundViewFrame];
        UIView *separatorView = [[UIView alloc] initWithFrame:separatorViewFrame];
        backgroundView.backgroundColor = [UIColor clearColor];
        separatorView.backgroundColor = [kColorConstants waitlistTableViewSideLabelColor:1.0f];
        
        [backgroundView addSubview:separatorView];
        
        [_tableView setBackgroundView:backgroundView];
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
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        // add shadow
        _collectionView.layer.masksToBounds = NO;
        _collectionView.layer.shadowOffset = CGSizeMake(-1, 0.5);
        _collectionView.layer.shadowRadius = 3;
        _collectionView.layer.shadowOpacity = 0.5;
    }
    
    return _collectionView;
}

@end
