//
//  StockOrderListViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface StockOrderListViewController : BaseViewController

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSString *fromType;//0商城，1自营
@property(nonatomic,strong)NSString *status;//状态 1：待确认，2：待收货 3:已收货，4 撤销 7 待支付 10退货

@end
