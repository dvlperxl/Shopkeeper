//
//  GoodsDatePicker.h
//  Dev
//
//  Created by xl on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDatePicker;

@protocol GoodsDatePickerDelegate <NSObject>

@optional;
- (void)datePickerView:(GoodsDatePicker *)view datePicker:(UIDatePicker *)datePicker selectedDate:(NSDate *)date;
@end

@interface GoodsDatePicker : UIView

@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic,weak) id<GoodsDatePickerDelegate> delegate;

- (void)showInController:(UIViewController *)viewController;
@end
