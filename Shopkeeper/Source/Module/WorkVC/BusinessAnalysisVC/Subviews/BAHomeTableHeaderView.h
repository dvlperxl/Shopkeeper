//
//  BAHomeTableHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAHomeTableHeaderViewModel;

@interface BAHomeTableHeaderView : UIView

- (void)reloadData:(BAHomeTableHeaderViewModel*)model;

@end

@interface BAHomeTableHeaderViewModel : NSObject

@property(nonatomic,copy)NSString *todayamount;
@property(nonatomic,copy)NSString *todayCreditAmount;

@property(nonatomic,copy)NSString *currMonthFinalAmount;
@property(nonatomic,copy)NSString *monthProfit;
@property(nonatomic,copy)NSString *currMonthCreditAmount;


@end
