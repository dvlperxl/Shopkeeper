//
//  GoodsDetailViewController.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailViewController : BaseViewController

@property(nonatomic,copy) NSString *storeId;
@property(nonatomic,copy) NSString *goodsId;
@property (nonatomic,strong) NSArray *categoryList;
@end
