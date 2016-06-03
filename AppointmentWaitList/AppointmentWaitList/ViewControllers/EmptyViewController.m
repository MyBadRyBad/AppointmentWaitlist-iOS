//
//  EmptyViewController.m
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 6/3/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import "EmptyViewController.h"
#import "kColorConstants.h"
#import "kConstants.h"

@interface EmptyViewController ()

@property (nonatomic, strong) UILabel *emptyLabel;

@end

@implementation EmptyViewController

#pragma mark -
#pragma mark - View Controller lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark -
#pragma mark - setup
- (void)setup {
    [self setupView];
    [self setupConstraints];
}

- (void)setupView {
    [self.view addSubview:[self emptyLabel]];
}

- (void)setupConstraints {
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_emptyLabel);
    NSDictionary *metrics = @{@"labelHeight" : @(kFontSizeEmptyLabel * 2)};
    
    // setup vertical constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_emptyLabel(labelHeight)]" options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emptyLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    // setup horizontal constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_emptyLabel]|" options:0 metrics:metrics views:viewsDictionary]];
    
}

#pragma mark -
#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - getter method
- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _emptyLabel.font = [UIFont systemFontOfSize:kFontSizeEmptyLabel];
        _emptyLabel.textColor = [kColorConstants waitListTableViewCellNotSelectedColor:1.0f];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.text = NSLocalizedString(@"Unused", nil);
    }
    
    return _emptyLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
