//
//  ActionButton.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/31/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "ActionButton.h"
#import "kConstants.h"

@implementation ActionButton

#pragma mark -
#pragma mark - initializer
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
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    [self addSubview:[self nameLabel]];
    [self addSubview:[self iconImageView]];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_nameLabel, _iconImageView);
    NSDictionary *metrics = @{@"imageViewWidth" : @(40)};
    
    
    // add vertical constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_iconImageView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    // add horizontal constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nameLabel]-[_iconImageView(imageViewWidth)]|" options:0 metrics:metrics views:viewsDictionary]];
    
}


#pragma mark - 
#pragma mark - getter methods
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _nameLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _iconImageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
