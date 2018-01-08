//
//  GoodsCategoryPickerView.h
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsCategoryPickerView;

NS_ASSUME_NONNULL_BEGIN
@protocol GoodsCategoryPickerViewDataSource <NSObject>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@protocol GoodsCategoryPickerViewDelegate <NSObject>

@optional;
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

/** pickerView选中的行数，从第0列开始，第n列结束*/
- (void)goodsPickerView:(GoodsCategoryPickerView *)view pickerView:(UIPickerView *)pickerView selectedRows:(NSArray *)rows;

- (void)goodsPickerViewDidDismiss:(GoodsCategoryPickerView *)view;
@end

@interface GoodsCategoryPickerView : UIView

@property (nonatomic,weak) id<GoodsCategoryPickerViewDataSource> dataSource;
@property (nonatomic,weak) id<GoodsCategoryPickerViewDelegate> delegate;

- (void)showInController:(UIViewController *)viewController;
@end
NS_ASSUME_NONNULL_END
