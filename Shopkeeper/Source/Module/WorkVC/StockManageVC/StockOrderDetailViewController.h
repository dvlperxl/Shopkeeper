//
//  StockOrderDetailViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface StockOrderDetailViewController : BaseViewController

@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSNumber *tag;
@property(nonatomic,strong)NSString *status;

@end
