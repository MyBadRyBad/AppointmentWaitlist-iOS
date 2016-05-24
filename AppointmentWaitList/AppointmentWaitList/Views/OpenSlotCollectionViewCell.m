//
//  OpenSlotCollectionViewCell.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "OpenSlotCollectionViewCell.h"
#import "kConstants.h"

static CGFloat const kLabelHeight = 14.0f;

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
    
    self.backgroundColor = [UIColor whiteColor];
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
    
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)dayNameLabel {
    if (!_dayNameLabel) {
        _dayNameLabel = [[UILabel alloc] init];
        _dayNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dayNameLabel.font = [UIFont systemFontOfSize:kFontSizeOpenSlot];
        _dayNameLabel.textAlignment = NSTextAlignmentCenter;
        _dayNameLabel.text = @"WED";
    }
    
    return _dayNameLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _monthLabel.font = [UIFont systemFontOfSize:kFontSizeOpenSlot];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.text = @"September";
    }
    
    return _monthLabel;
}

- (UILabel *)dayNumberLabel {
    if (!_dayNumberLabel) {
        _dayNumberLabel = [[UILabel alloc] init];
        _dayNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dayNumberLabel.font = [UIFont systemFontOfSize:kFontSizeOpenSlot];
        _dayNumberLabel.textAlignment = NSTextAlignmentCenter;
        _dayNumberLabel.text = @"10";
    }
    
    return _dayNumberLabel;
}

- (UILabel *)todayLabel {
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc] init];
        _todayLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _todayLabel.font = [UIFont systemFontOfSize:kFontSizeOpenSlot];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _todayLabel;
}

@end
