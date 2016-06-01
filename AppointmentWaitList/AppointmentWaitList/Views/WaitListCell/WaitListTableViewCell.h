//
//  WaitListTableViewCell.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitListTableViewCell : UITableViewCell


// hacky solution to allow labels to overlap cells
@property (nonatomic, strong) UILabel *topTimeLabel;
@property (nonatomic, strong) UILabel *bottomTimeLabel;

@property (nonatomic, strong) UILabel *topAmpmLabel;
@property (nonatomic, strong) UILabel *bottomAmpmLabel;

@property (nonatomic, strong) UIView *lineSeparatorView;

- (void)setBottomCircleViewVisible:(BOOL)bottomCircleViewVisible;
- (void)setTopCircleViewVisible:(BOOL)topCircleViewVisible;
- (void)highlightLineSeparator:(BOOL)shouldHighlight;

- (void)setEnabled:(BOOL)enabled;
- (BOOL)isEnabled;

@end
