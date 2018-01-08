//
//  OrderListViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderListViewController : BaseViewController

@property(nonatomic,copy)NSString *storeId;
@property(nonatomic,copy)NSString *status;//订单状态(1 待确认2 待送货 3 已收货 4.已撤单 5 废单 7:待支付)
@property(nonatomic,copy)NSString *navTitle;

@end
//：farmercustomer=141841  storeId=856

