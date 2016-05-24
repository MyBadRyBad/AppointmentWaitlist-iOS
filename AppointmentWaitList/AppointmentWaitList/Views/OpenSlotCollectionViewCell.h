//
//  OpenSlotCollectionViewCell.h
//  AppointmentWaitList
//
//  Created by Ryan Badilla on 5/23/16.
//  Copyright © 2016 Newdesto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenSlotCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *dayNameLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayNumberLabel;

- (void)setCellAsToday:(BOOL)setCellAsToday;

@end
