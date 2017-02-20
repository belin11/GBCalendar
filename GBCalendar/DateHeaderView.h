//
//  DateHeaderView.h
//  calendar
//
//  Created by midas on 2017/2/18.
//  Copyright © 2017年 midas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateHeaderView;

@protocol DateHeaderViewDelegate <NSObject>

- (void)dateHeaderView:(DateHeaderView *)dateHeaderView didClickedWithIndex:(NSInteger)index;

@end
@interface DateHeaderView : UIView

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, weak) id <DateHeaderViewDelegate> delegate;
@end
