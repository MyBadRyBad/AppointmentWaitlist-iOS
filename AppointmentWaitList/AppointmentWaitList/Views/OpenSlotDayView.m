//
//  OpenSlotDayView.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "OpenSlotDayView.h"

@implementation OpenSlotDayView

#pragma mark -
#pragma mark - initialization
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupViews];
        [self setupConstraints];
    }
    
    return self;
}


#pragma mark -
#pragma mark - setup 
- (void)setupViews {
    [self addSubview:[self dateLabel]];
    [self addSubview:[self dayNameLabel]];
    [self addSubview:[self monthLabel]];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_dayNameLabel, _monthLabel, _dateLabel);
    NSDictionary *metrics = nil;
    
    // setup vertical constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dayNameLabel][_monthLabel(==_dayNameLabel)][_dateLabel(==_dayNameLabel)]|" options:0 metrics:metrics views:viewsDictionary]];
    
    // setup horizontal constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dateLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_monthLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dayNameLabel]|" options:0 metrics:metrics views:viewsDictionary]];
}


#pragma mark -
#pragma mark - getter methods
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    
    return _dateLabel;
}

- (UILabel *)dayNameLabel {
    if (!_dayNameLabel) {
        _dayNameLabel = [[UILabel alloc] init];
        _dayNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        
    }
    
    return _dayNameLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _monthLabel;
}


@end
