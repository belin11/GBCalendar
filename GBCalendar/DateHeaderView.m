//
//  DateHeaderView.m
//  calendar
//
//  Created by midas on 2017/2/18.
//  Copyright © 2017年 midas. All rights reserved.
//

#import "DateHeaderView.h"

@interface DateHeaderView ()

@property(nonatomic, weak) UILabel *dateLabel;

@property(nonatomic, weak) UIButton *previousBtn;
@property(nonatomic, weak) UIButton *nextBtn;

@end

@implementation DateHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpAllChildView];
    }
    
    return self;
}

- (void)setUpAllChildView {
    
    UILabel *dateLabel = [UILabel new];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UIButton *previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousBtn setTitle:@"上个月" forState:UIControlStateNormal];
    [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:previousBtn];
    previousBtn.tag = -1;
    [previousBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.previousBtn = previousBtn;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下个月" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextBtn.tag = 1;
    [nextBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:nextBtn];
 
    self.nextBtn = nextBtn;
}

- (void)click:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(dateHeaderView:didClickedWithIndex:)]) {
        
        [_delegate dateHeaderView:self didClickedWithIndex:sender.tag];
    }
}
- (void)setDateStr:(NSString *)dateStr {
    
    _dateStr = dateStr;
    
    self.dateLabel.text = dateStr;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.dateLabel.frame = CGRectMake(0, 0, 100, self.bounds.size.height);
    self.dateLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    self.previousBtn.frame = CGRectMake(10, 0, 60, self.bounds.size.height);
    
    self.nextBtn.frame = CGRectMake(self.bounds.size.width - 10 - 60, 0, 60, self.bounds.size.height);
    
}
@end
