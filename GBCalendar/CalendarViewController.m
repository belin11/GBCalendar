
//
//  Calendar\ViewController.m
//  calendar
//
//  Created by midas on 2017/2/20.
//  Copyright © 2017年 midas. All rights reserved.
//

#import "CalendarViewController.h"
#import "GBCalendar.h"

@interface CalendarViewController () <GBCalendarDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    GBCalendar *calendar = [[GBCalendar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 700)];
    calendar.delegate = self;
    [self.view addSubview:calendar];
}

- (void)calendar:(GBCalendar *)calendar didSelectDate:(NSDate *)date {
    
    NSLog(@"%@",date);
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
