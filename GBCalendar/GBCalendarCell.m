//
//  CalendarCell.m
//  calendar
//
//  Created by midas on 2017/2/18.
//  Copyright © 2017年 midas. All rights reserved.
//

#import "GBCalendarCell.h"

@interface GBCalendarCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end
@implementation CalendarCell

- (void)setTodayIsRed:(BOOL)todayIsRed {
    
    _todayIsRed = todayIsRed;
    if (todayIsRed) {
        
        _dayLabel.textColor = [UIColor redColor];

    } else {
        
        _dayLabel.textColor = [UIColor blackColor];
    }
}

- (void)setDate:(NSDate *)date {
    
    _date = date;
    
    if (_date == nil) {
        
        self.dayLabel.text = nil;
        return;
    }
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd";
    
    NSString *day = [dateFormatter stringFromDate:date];
    
    if ([day hasPrefix:@"0"]) {
        
     day = [day stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    
    self.dayLabel.text = day;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

@end
