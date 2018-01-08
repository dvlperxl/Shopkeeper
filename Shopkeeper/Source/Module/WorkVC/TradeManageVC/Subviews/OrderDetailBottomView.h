//
//  OrderDetailBottomView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderDetailBottomViewDelegate <NSObject>

- (void)orderDetailBottomViewDidSelectBottomButtonIndex:(NSInteger)index;

@end

@interface OrderDetailBottomView : UIView

@property(nonatomic,weak) id<OrderDetailBottomViewDelegate> delegate;

+ (instancetype)orderDetailBottomViewWithButtonTitles:(NSArray<NSString*>*)titles;

- (void)reloadData:(NSArray<NSString*>*)titles;

@end
