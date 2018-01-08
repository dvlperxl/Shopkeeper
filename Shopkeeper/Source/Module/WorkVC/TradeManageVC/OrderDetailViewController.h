//
//  OrderDetailViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController

@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *status;//订单状态(1 待确认2 待送货 3 已收货 4.已撤单 5 废单 7:待支付) 9

@end
