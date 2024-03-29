//
//  OpenSlotCollectionViewCell.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "OpenSlotCollectionViewCell.h"
#import "kColorConstants.h"
#import "kConstants.h"

static CGFloat const kLabelHeight = 14.0f;

@interface OpenSlotCollectionViewCell()

@end

@implementation OpenSlotCollectionViewCell

#pragma mark -
#pragma mark - initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

#pragma mark -
#pragma mark - setup
- (void)setup {
    [self setupView];
    [self setupConstraints];
}

- (void)setupView {
    [self.contentView addSubview:[self dayNameLabel]];
    [self.contentView addSubview:[self monthLabel]];
    [self.contentView addSubview:[self dayNumberLabel]];
    [self.contentView addSubview:[self todayLabel]];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_dayNameLabel, _monthLabel, _dayNumberLabel, _todayLabel);
    NSDictionary *metrics = @{@"labelHeight" : @(kLabelHeight)};
    
    // setup vertical constraints
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_dayNameLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_monthLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_dayNumberLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_monthLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_monthLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_todayLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    // setup horizontal constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dayNameLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_monthLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dayNumberLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_todayLabel]|" options:0 metrics:metrics views:viewsDictionary]];
}

#pragma mark -
#pragma mark - set cell
- (void)setCellAsToday:(BOOL)setCellAsToday {
    
    _dayNameLabel.hidden = setCellAsToday;
    _monthLabel.hidden = setCellAsToday;
    _dayNumberLabel.hidden = setCellAsToday;
    _todayLabel.hidden = !setCellAsToday;
}

- (void)setCellAsSelected:(BOOL)setAsSelected {
    if (setAsSelected) {
        self.backgroundColor = [kColorConstants openSlotDayViewBackgroundColorSelected:1.0f];
        
        _dayNameLabel.textColor = [UIColor whiteColor];
        _monthLabel.textColor = [UIColor whiteColor];
        _dayNumberLabel.textColor = [UIColor whiteColor];
        _todayLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [kColorConstants openSlotDayViewBackgroundColotNotSelected:1.0f];
        
        _dayNameLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
        _monthLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
        _dayNumberLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
        _todayLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
    }
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)dayNameLabel {
    if (!_dayNameLabel) {
        _dayNameLabel = [[UILabel alloc] init];
        _dayNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dayNameLabel.font = [UIFont boldSystemFontOfSize:kFontSizeOpenSlot];
        _dayNameLabel.textAlignment = NSTextAlignmentCenter;
        _dayNameLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
    }
    
    return _dayNameLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _monthLabel.font = [UIFont systemFontOfSize:kFontSizeOpenSlot];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
    }
    
    return _monthLabel;
}

- (UILabel *)dayNumberLabel {
    if (!_dayNumberLabel) {
        _dayNumberLabel = [[UILabel alloc] init];
        _dayNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dayNumberLabel.font = [UIFont boldSystemFontOfSize:kFontSizeOpenSlot];
        _dayNumberLabel.textAlignment = NSTextAlignmentCenter;
        _dayNameLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
    }
    
    return _dayNumberLabel;
}

- (UILabel *)todayLabel {
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc] init];
        _todayLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _todayLabel.font = [UIFont boldSystemFontOfSize:kFontSizeOpenSlot + 2];
        _todayLabel.textColor = [kColorConstants openSlotDayTextColor:1.0f];
        _todayLabel.text = NSLocalizedString(@"Today", nil);
        _todayLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _todayLabel;
}

@end
