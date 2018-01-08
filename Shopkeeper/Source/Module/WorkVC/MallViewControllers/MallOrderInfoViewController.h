//
//  MallOrderInfoViewController.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//  确认订单页面

#import "BaseViewController.h"

@interface MallOrderInfoViewController : BaseViewController

@property (nonatomic,strong) NSNumber *storeId;
@property (nonatomic,strong) NSNumber *showShopping;
@property (nonatomic,copy) NSString *wholesaleId;
@property (nonatomic,copy) NSString *goodsId;
@property (nonatomic,copy) NSString *goodsWrapId;
@property (nonatomic,strong) NSNumber *count;
@end
