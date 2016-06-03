//
//  WaitListTableViewCell.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "kColorConstants.h"
#import "kConstants.h"

static CGFloat const kCircleViewSize = 14.0f;
static CGFloat const kLabelHeight = 20.0f;

static CGFloat const kLineSeparatorDefaultHeight = 0.5f;
static CGFloat const kLineSeparatorHighlightedHeight = 2.0f;

@interface WaitListTableViewCell()

@property (nonatomic, strong) UIView *bottomCircleView;
@property (nonatomic, strong) UIView *topCircleView;

@property (nonatomic, strong) UIView *timeAreaView;

@property (nonatomic, strong) NSLayoutConstraint *layoutConstraintLineSeparatorHeight;

// this.selected not changing --> hacky solution part 2 electric boogaloo
@property (nonatomic, assign) BOOL enabled;

@end

@implementation WaitListTableViewCell


#pragma mark -
#pragma mark - initialization
- (instancetype)init {
    self = [super init];
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    
    return self;
}

#pragma mark -
#pragma mark - awakeFromNib
- (void)awakeFromNib {
    [super awakeFromNib];

}

#pragma mark -
#pragma mark - setup
- (void)setup {
    [self setupView];
}

- (void)setupView {
    [self.contentView addSubview:[self timeAreaView]];
    [self.contentView addSubview:[self bottomCircleView]];
    [self.contentView addSubview:[self topCircleView]];
    [self.contentView addSubview:[self lineSeparatorView]];
    [self.contentView addSubview:[self topTimeLabel]];
    [self.contentView addSubview:[self topAmpmLabel]];
    [self.contentView addSubview:[self bottomTimeLabel]];
    [self.contentView addSubview:[self bottomAmpmLabel]];
    
    [self setupConstraints];
    
    // round the circle views
    _bottomCircleView.layer.cornerRadius = kCircleViewSize * 0.5;
    _topCircleView.layer.cornerRadius = kCircleViewSize * 0.5;
    
    // unselect
    [self setEnabled:NO];
    [self setTopCircleViewVisible:NO];
    [self setBottomCircleViewVisible:NO];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_topTimeLabel,
                                                                   _topAmpmLabel,
                                                                   _bottomTimeLabel,
                                                                   _bottomAmpmLabel,
                                                                   _timeAreaView,
                                                                   _bottomCircleView,
                                                                   _topCircleView,
                                                                   _lineSeparatorView);
    NSDictionary *metrics = @{@"circleViewSize" : @(kCircleViewSize),
                              @"timeAreaWidth" : @(kImageTimeAreaWidth),
                              @"labelHeight" : @(20),
                              @"ampmLabelWidth" : @(24)};
    
    // setup vertical constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTimeLabel(labelHeight)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomAmpmLabel(labelHeight)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topTimeLabel(labelHeight)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topAmpmLabel(labelHeight)]" options:0 metrics:metrics views:viewsDictionary]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_timeAreaView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomCircleView(circleViewSize)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topCircleView(circleViewSize)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomTimeLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:(kLabelHeight * 0.5)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomAmpmLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:(kLabelHeight * 0.5)]];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_topTimeLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:-(kLabelHeight * 0.5)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_topAmpmLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:-(kLabelHeight * 0.5)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_lineSeparatorView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCircleView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:(kCircleViewSize * 0.5)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_topCircleView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:-(kCircleViewSize * 0.5)]];
    
    _layoutConstraintLineSeparatorHeight = [NSLayoutConstraint constraintWithItem:_lineSeparatorView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:kLineSeparatorDefaultHeight];
    
    [self addConstraint:_layoutConstraintLineSeparatorHeight];
    
    
    
    
    // setup horizontal constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_bottomAmpmLabel(ampmLabelWidth)]-[_bottomTimeLabel]-|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_topAmpmLabel(ampmLabelWidth)]-[_topTimeLabel]-|" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_bottomCircleView(circleViewSize)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_topCircleView(circleViewSize)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_timeAreaView(timeAreaWidth)][_lineSeparatorView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_topCircleView
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:0.8
                                                                  constant:20.0f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomCircleView
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:0.8
                                                                  constant:20.0f]];
}

#pragma mark -
#pragma mark - setSelected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.backgroundColor = [kColorConstants waitListTableViewCellSelectedColor:1.0f];
    } else {
        self.backgroundColor = [kColorConstants waitListTableViewCellNotSelectedColor:1.0f];
    }
    
    _enabled = enabled;
}

#pragma mark -
#pragma mark - separator view methods
- (void)setBottomCircleViewVisible:(BOOL)bottomCircleViewVisible {
    if (_bottomCircleView) {
        _bottomCircleView.hidden = !bottomCircleViewVisible;
        if (bottomCircleViewVisible) {
            _lineSeparatorView.layer.borderWidth = 1.0f;
        } else {
            _lineSeparatorView.layer.borderWidth = 0.0f;
        }
    }
}

- (void)setTopCircleViewVisible:(BOOL)topCircleViewVisible {
    if (_topCircleView) {
        _topCircleView.hidden = !topCircleViewVisible;
    }
}

- (void)highlightLineSeparator:(BOOL)shouldHighlight {
    if (shouldHighlight) {
        _layoutConstraintLineSeparatorHeight.constant = kLineSeparatorHighlightedHeight;
        [self.contentView layoutIfNeeded];
        
        _lineSeparatorView.backgroundColor = [kColorConstants waitListTableViewSeparatorLineColorSelected:1.0f];
        
    } else {
        _layoutConstraintLineSeparatorHeight.constant = kLineSeparatorDefaultHeight;
        [self.contentView layoutIfNeeded];
        
        _lineSeparatorView.backgroundColor = [kColorConstants waitListTableViewSeparatorLineColotNotSelected:1.0f];
    }
}

#pragma mark -
#pragma mark - isEnabled
- (BOOL)isEnabled {
    return _enabled;
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)topTimeLabel {
    if (!_topTimeLabel) {
        _topTimeLabel = [[UILabel alloc] init];
        _topTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _topTimeLabel.font = [UIFont systemFontOfSize:kFontSizeWaitListTime];
        _topTimeLabel.textColor = [kColorConstants waitlistTableViewWaitListTextColorNotSelected:1.0f];
    }
    
    return _topTimeLabel;
}

- (UILabel *)bottomTimeLabel {
    if (!_bottomTimeLabel) {
        _bottomTimeLabel = [[UILabel alloc] init];
        _bottomTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomTimeLabel.font = [UIFont systemFontOfSize:kFontSizeWaitListTime];
        _bottomTimeLabel.textColor = [kColorConstants waitlistTableViewWaitListTextColorNotSelected:1.0f];
        
    }
    
    return _bottomTimeLabel;
}

- (UILabel *)topAmpmLabel {
    if (!_topAmpmLabel) {
        _topAmpmLabel = [[UILabel alloc] init];
        _topAmpmLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _topAmpmLabel.font = [UIFont boldSystemFontOfSize:kFontSizeWaitListTime - 1];
        _topAmpmLabel.textColor = [kColorConstants waitlistTableViewWaitListTextColorNotSelected:1.0f];
    }
    
    return _topAmpmLabel;
}

- (UILabel *)bottomAmpmLabel {
    if (!_bottomAmpmLabel) {
        _bottomAmpmLabel = [[UILabel alloc] init];
        _bottomAmpmLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomAmpmLabel.font = [UIFont boldSystemFontOfSize:kFontSizeWaitListTime - 1];
        _bottomAmpmLabel.textColor = [kColorConstants waitlistTableViewWaitListTextColorNotSelected:1.0f];
    }
    
    return _bottomAmpmLabel;
}

- (UIView *)bottomCircleView {
    if (!_bottomCircleView) {
        _bottomCircleView = [[UIView alloc] init];
        _bottomCircleView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomCircleView.backgroundColor = [kColorConstants waitListTableViewSeparatorLineColorSelected:1.0f];
    }
    
    return _bottomCircleView;
}

- (UIView *)topCircleView {
    if (!_topCircleView) {
        _topCircleView = [[UIView alloc] init];
        _topCircleView.translatesAutoresizingMaskIntoConstraints = NO;
        _topCircleView.backgroundColor = [kColorConstants waitListTableViewSeparatorLineColorSelected:1.0f];
    }
    
    return _topCircleView;
}

- (UIView *)lineSeparatorView {
    if (!_lineSeparatorView) {
        _lineSeparatorView = [[UIView alloc] init];
        _lineSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _lineSeparatorView.backgroundColor = [kColorConstants waitListTableViewSeparatorLineColotNotSelected:1.0f];
        
    }
    
    return  _lineSeparatorView;
}


- (UIView *)timeAreaView {
    if (!_timeAreaView) {
        _timeAreaView = [[UIView alloc] init];
        _timeAreaView.translatesAutoresizingMaskIntoConstraints = NO;
        _timeAreaView.backgroundColor = [kColorConstants waitlistTableViewSideLabelColor:1.0f];
    }
    
    return _timeAreaView;
}
@end
