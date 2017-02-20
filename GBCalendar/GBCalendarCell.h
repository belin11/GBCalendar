//
//  CalendarCell.h
//  calendar
//
//  Created by midas on 2017/2/18.
//  Copyright © 2017年 midas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBCalendarCell : UICollectionViewCell

@property (nonatomic, copy) NSDate *date;

@property (nonatomic, assign) BOOL todayIsRed;
@end
