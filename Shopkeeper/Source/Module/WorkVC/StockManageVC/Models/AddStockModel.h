//
//  AddStockModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemarkTableViewCell.h"
#import "SettlementAmountTableViewCell.h"

@interface AddStockModel : NSObject

@property(nonatomic,strong)NSString *supplierName;//供应商名称
@property(nonatomic,strong)NSString *supplierId;//供应商Id
@property(nonatomic,strong)NSArray *goodsList;//商品列表
@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)KKTableViewModel *tableViewModel;
@property(nonatomic,strong)RemarkTableViewCellModel *prepaidData;

@property(nonatomic,strong)SettlementAmountTableViewCellModel *creditData;
@property(nonatomic,strong)SettlementAmountTableViewCellModel *finalAmountData;


- (NSArray*)purchaseDetail;
- (NSMutableDictionary*)purchase;
- (NSString*)totalAmount;


@end
