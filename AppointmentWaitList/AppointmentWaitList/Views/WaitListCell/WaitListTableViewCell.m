//
//  WaitListTableViewCell.m
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "WaitListTableViewCell.h"

@interface WaitListTableViewCell()

@property (nonatomic, strong) UIView *upperCircleView;
@property (nonatomic, strong) UIView *lowerCircleView;
@property (nonatomic, strong) UIView *lineSeparationView;

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
    [self setupConstraints];
}

- (void)setupView {
    [self addSubview:[self timeAreaView]];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_timeAreaView);
    NSDictionary *metrics = @{@"timeAreaViewWidth" : @(80)};
    
    // setup vertical constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_timeAreaView]|" options:0 metrics:metrics views:viewsDictionary]];
    
    // setup horizontal constraints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_timeAreaView(timeAreaViewWidth)]" options:0 metrics:metrics views:viewsDictionary]];
    
}

#pragma mark -
#pragma mark - setSelected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated lowerCircleViewVisible:(BOOL)lowerCircleViewVisible upperCircleViewVisible:(BOOL)upperCircleViewVisible {
    [super setSelected:selected animated:animated];
    [self setLowerCircleViewVisible:lowerCircleViewVisible];
    [self setUpperCircleViewVisible:upperCircleViewVisible];
}


#pragma mark -
#pragma mark - separator view methods
- (void)setLowerCircleViewVisible:(BOOL)lowerCircleViewVisible {
    if (_lowerCircleView) {
        _lowerCircleView.hidden = lowerCircleViewVisible;
    }
}

- (void)setUpperCircleViewVisible:(BOOL)upperCircleViewVisible {
    if (_upperCircleView) {
        _upperCircleView.hidden = upperCircleViewVisible;
    }
}

#pragma mark -
#pragma mark - getter methods
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _timeLabel;
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
