//
//  WaitListTableViewCell.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *topTimeLabel;
@property (nonatomic, strong) UILabel *bottomTimeLabel;

@property (nonatomic, strong) UILabel *topAmpmLabel;
@property (nonatomic, strong) UILabel *bottomAmpmLabel;

// this.selected not changing --> hacky solution
@property (nonatomic, assign) BOOL enabled;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated circleViewVisible:(BOOL)circleViewVisible;

- (void)setBottomCircleViewVisible:(BOOL)bottomCircleViewVisible;
- (void)setTopCircleViewVisible:(BOOL)topCircleViewVisible;


@end
