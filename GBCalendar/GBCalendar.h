//
//  GBCalendar.h
//  calendar
//
//  Created by midas on 2017/2/20.
//  Copyright © 2017年 midas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBCalendar;
@class GBCalendarCell;

@protocol GBCalendarDelegate <NSObject>

- (void)calendar:(GBCalendar *)calendar didSelectDate:(NSDate *)date;

@end

@protocol GBCalendarDataSource <NSObject>

- (GBCalendarCell *)calendar:(GBCalendar *)calendar cellForDate:(NSDate *)date;

@end

@interface GBCalendar : UIView

@property (nonatomic, weak) id <GBCalendarDelegate> delegate;
@property (nonatomic, weak) id <GBCalendarDataSource> dataSource;

@end
