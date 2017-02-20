//
//  GBCalendar.m
//  calendar
//
//  Created by midas on 2017/2/20.
//  Copyright © 2017年 midas. All rights reserved.
//

#import "GBCalendar.h"
#import "GBCalendarCell.h"
#import "DateHeaderView.h"
#import "WeekHeaderView.h"

#define KWidth [UIScreen mainScreen].bounds.size.width/7
static NSString * const reuseIdentifier = @"Cell";

@interface GBCalendar () <UICollectionViewDelegate, UICollectionViewDataSource ,DateHeaderViewDelegate>

@property (nonatomic, weak) DateHeaderView *dateHeaderView;
@property (nonatomic, weak) WeekHeaderView *weekHeaderView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger firstWeekday;
@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) NSMutableArray *dates;
@property (nonatomic, assign) NSInteger dayInMonth;
@property (nonatomic, assign) NSInteger weekInMonth;
@property (nonatomic, strong) NSString *todayDateStr; // 年月
@end

@implementation GBCalendar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.currentDate = [NSDate date];
        self.dateFormatter = [NSDateFormatter new];

        self.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

        [self setUpAllChildView];
        [self getDatesAndDaysInCalendarCellWithIndex:0];
    }
    return self;
}

- (void)setUpAllChildView {
    
    DateHeaderView *dateHeaderView = [[DateHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, 40)];
    [self addSubview:dateHeaderView];
    self.dateHeaderView = dateHeaderView;
    dateHeaderView.delegate = self;
    
    WeekHeaderView *weekHeaderView = [[WeekHeaderView alloc] initWithFrame:CGRectMake(0, 64 + 40, self.bounds.size.width, 30)];
    
    [self addSubview:weekHeaderView];
    weekHeaderView.weekTitles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    // 流式布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(KWidth, KWidth);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    CGFloat collectionViewHeight = self.weekInMonth * KWidth;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64+40+30, self.bounds.size.width, collectionViewHeight) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self addSubview:self.collectionView];
    
    
}

- (void)dateHeaderView:(DateHeaderView *)dateHeaderView didClickedWithIndex:(NSInteger)index {
    
    [self getDatesAndDaysInCalendarCellWithIndex:index];
}

- (NSInteger)dayInMonth {
    
    // 一个月天数的范围
    NSRange daysRange = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.currentDate];
    _dayInMonth = daysRange.length;
    
    return _dayInMonth;
}

- (NSInteger)weekInMonth {
    
    // 一个月周数的范围
    NSRange weeksRange = [self.calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:self.currentDate];
    _weekInMonth = weeksRange.length;
    // 一个月的周数
    return  _weekInMonth;
}

- (void)getDateInDateHeaderViewWithIndex:(NSInteger)index {
    
    // 上个月或当月 下个月
    NSDate *nextMonth = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:index toDate:self.currentDate options:0];
    
    self.currentDate = nextMonth;
    
    self.dateFormatter.dateFormat = @"yyyy年MM月";
    
    NSString *dateStr = [self.dateFormatter stringFromDate:nextMonth];
    
    self.todayDateStr = dateStr;
    // 传值
    self.dateHeaderView.dateStr = dateStr;
    
}

- (void)getDatesAndDaysInCalendarCellWithIndex:(NSInteger)index {
    
    [self getDateInDateHeaderViewWithIndex:index];
    
    self.dateFormatter.dateFormat = @"yyyy年MM月dd日";
    
    [self.dates removeAllObjects];// 移除
    
    for (int i = 1; i <= self.dayInMonth; i++) {
        
        NSString *dateStr = [NSString stringWithFormat:@"%@%d日",self.todayDateStr, i];
        
        NSDate *date = [self.dateFormatter dateFromString:dateStr];
        
        [self.dates addObject:date];
        
        if (i == 1) { // 一月第一天
            
            NSInteger weekday = [self.calendar component:NSCalendarUnitWeekday fromDate:date];
            self.firstWeekday = weekday;
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.weekInMonth * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GBCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.date = nil;
    
    if (indexPath.row >= self.firstWeekday - 1 && indexPath.row < self.firstWeekday + self.dates.count - 1) {
        
        NSDate *date = self.dates[indexPath.row - self.firstWeekday + 1];
        
        cell.date = date;
        
        if ([[self.dateFormatter stringFromDate:date] isEqualToString:[self.dateFormatter stringFromDate:[NSDate date]]]) {
            
            cell.todayIsRed = YES;
        } else {
            
            cell.todayIsRed = NO;
        }
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row >= self.firstWeekday - 1 && indexPath.row < self.firstWeekday + self.dates.count - 1) {
        
        NSDate *date = self.dates[indexPath.row - (self.firstWeekday - 1)];
        
        NSString *selectedDateStr = [self.dateFormatter stringFromDate:date];
        NSLog(@"%@",selectedDateStr);
        if ([_delegate respondsToSelector:@selector(calendar:didSelectDate:)]) {
            
            [_delegate calendar:self didSelectDate:date];
        }
    }
}


- (NSMutableArray *)dates {
    
    if (_dates == nil) {
        
        _dates = [NSMutableArray array];
    }
    return _dates;
}
@end
