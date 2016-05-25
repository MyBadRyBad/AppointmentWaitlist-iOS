//
//  WaitListTableViewCell.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "kConstants.h"

static CGFloat kCircleViewSize = 14.0f;
static CGFloat kTimeAreaWidth = 90.0f;
static CGFloat kLabelHeight = 20.0f;

@interface WaitListTableViewCell()

@property (nonatomic, strong) UIView *bottomCircleView;
@property (nonatomic, strong) UIView *topCircleView;
@property (nonatomic, strong) UIView *lineSeparatorView;

@property (nonatomic, strong) UIView *timeAreaView;



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
    self.enabled = NO;
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
                              @"timeAreaWidth" : @(kTimeAreaWidth),
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
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineSeparatorView(0.5)]" options:0 metrics:metrics views:viewsDictionary]];
    
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



- (void)setSelected:(BOOL)selected animated:(BOOL)animated circleViewVisible:(BOOL)circleViewVisible {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self setBottomCircleViewVisible:YES];
        [self setTopCircleViewVisible:YES];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setBottomCircleViewVisible:NO];
        [self setTopCircleViewVisible:NO];
    }
    
    _enabled = selected;
}

#pragma mark -
#pragma mark - separator view methods
- (void)setBottomCircleViewVisible:(BOOL)bottomCircleViewVisible {
    if (_bottomCircleView) {
        _bottomCircleView.hidden = !bottomCircleViewVisible;
        if (bottomCircleViewVisible) {
            _lineSeparatorView.layer.borderWidth = 2.0f;
        }
    }
}

- (void)setTopCircleViewVisible:(BOOL)topCircleViewVisible {
    if (_topCircleView) {
        _topCircleView.hidden = !topCircleViewVisible;
    }
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)topTimeLabel {
    if (!_topTimeLabel) {
        _topTimeLabel = [[UILabel alloc] init];
        _topTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _topTimeLabel.font = [UIFont systemFontOfSize:kFontSizeWaitListTime];
        _topTimeLabel.text = @"12:00";
    }
    
    return _topTimeLabel;
}

- (UILabel *)bottomTimeLabel {
    if (!_bottomTimeLabel) {
        _bottomTimeLabel = [[UILabel alloc] init];
        _bottomTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomTimeLabel.font = [UIFont systemFontOfSize:kFontSizeWaitListTime];
        _bottomTimeLabel.text = @"12:00";
        
    }
    
    return _bottomTimeLabel;
}

- (UILabel *)topAmpmLabel {
    if (!_topAmpmLabel) {
        _topAmpmLabel = [[UILabel alloc] init];
        _topAmpmLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _topAmpmLabel.font = [UIFont boldSystemFontOfSize:kFontSizeWaitListTime - 1];
        _topAmpmLabel.text = @"PM";
    }
    
    return _topAmpmLabel;
}

- (UILabel *)bottomAmpmLabel {
    if (!_bottomAmpmLabel) {
        _bottomAmpmLabel = [[UILabel alloc] init];
        _bottomAmpmLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomAmpmLabel.font = [UIFont boldSystemFontOfSize:kFontSizeWaitListTime - 1];
        _bottomAmpmLabel.text = @"PM";
    }
    
    return _bottomAmpmLabel;
}

- (UIView *)bottomCircleView {
    if (!_bottomCircleView) {
        _bottomCircleView = [[UIView alloc] init];
        _bottomCircleView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomCircleView.backgroundColor = [UIColor blueColor];
    }
    
    return _bottomCircleView;
}

- (UIView *)topCircleView {
    if (!_topCircleView) {
        _topCircleView = [[UIView alloc] init];
        _topCircleView.translatesAutoresizingMaskIntoConstraints = NO;
        _topCircleView.backgroundColor = [UIColor blueColor];
    }
    
    return _topCircleView;
}

- (UIView *)lineSeparatorView {
    if (!_lineSeparatorView) {
        _lineSeparatorView = [[UIView alloc] init];
        _lineSeparatorView.translatesAutoresizingMaskIntoConstraints = NO;
        _lineSeparatorView.backgroundColor = [UIColor blackColor];
        
    }
    
    return  _lineSeparatorView;
}


- (UIView *)timeAreaView {
    if (!_timeAreaView) {
        _timeAreaView = [[UIView alloc] init];
        _timeAreaView.translatesAutoresizingMaskIntoConstraints = NO;
        _timeAreaView.backgroundColor = [UIColor grayColor];
    }
    
    return _timeAreaView;
}
@end
