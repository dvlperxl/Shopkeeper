//
//  DailyCheckModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyCheckModel : NSObject

@property(nonatomic,copy)NSDictionary *customerCounts;
@property(nonatomic,copy)NSDictionary *delivery;
@property(nonatomic,copy)NSDictionary *preapy;
@property(nonatomic,copy)NSDictionary *repayment;
@property(nonatomic,copy)NSDictionary *saleInfos;
@property(nonatomic,copy)NSString *dateString;

- (KKTableViewModel*)tableViewModel;

@end
