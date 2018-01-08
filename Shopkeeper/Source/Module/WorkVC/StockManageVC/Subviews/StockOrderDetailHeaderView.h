//
//  StockOrderDetailHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockOrderDetailHeaderViewModel;

@interface StockOrderDetailHeaderView : UIView

- (void)reloadData:(StockOrderDetailHeaderViewModel*)model;

@end

@interface StockOrderDetailHeaderViewModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *orderTime;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *orderStatus;

@end
