//
//  DistibutorManageModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistibutorManageModel : NSObject

- (KKTableViewModel*)tableViewModel:(NSArray*)orderList;

@end


@interface DistibutorOrderListInfo : NSObject<YYModel>

@property(nonatomic,assign)NSInteger deliverMethond;
@property(nonatomic,strong)NSNumber *finalAmount;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *insertTime;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *retailNo;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *wholesaleName;

- (KKCellModel*)cellModel;

@end

