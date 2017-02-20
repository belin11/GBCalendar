//
//  WeekHeaderView.m
//  calendar
//
//  Created by midas on 2017/2/18.
//  Copyright © 2017年 midas. All rights reserved.
//

#import "WeekHeaderView.h"

@implementation WeekHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self= [super initWithFrame:frame]) {
        
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
    }
}

- (void)setWeekTitles:(NSArray *)weekTitles {
    
    _weekTitles = weekTitles;
    
    for (int i = 0; i < weekTitles.count; i++) {
        
        UILabel *label = self.subviews[i];
        label.text = weekTitles[i];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width / 7;
    
    int i = 0;
    for (UILabel *label in self.subviews) {
        
        label.frame = CGRectMake(i * width, 0, width, self.bounds.size.height);
        
        i++;
    }
}
@end
