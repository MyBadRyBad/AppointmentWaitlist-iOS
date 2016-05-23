//
//  WaitListTableViewCell.h
//  AppointmentWaitlist
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated lowerCircleViewVisible:(BOOL)lowerCircleViewVisible upperCircleViewVisible:(BOOL)upperCircleViewVisible;

- (void)setLowerCircleViewVisible:(BOOL)lowerCircleViewVisible;
- (void)setUpperCircleViewVisible:(BOOL)upperCircleViewVisible;


@end
