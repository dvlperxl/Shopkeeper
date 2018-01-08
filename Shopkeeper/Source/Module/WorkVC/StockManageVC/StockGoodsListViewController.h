//
//  StockGoodsListViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, StockGoodsListViewControllerType) {
    StockGoodsListViewControllerTypeStock = 0,                     // 进货
    StockGoodsListViewControllerTypeReicpePackageAddPres           // 处方套餐新增商品
};

@interface StockGoodsListViewController : BaseViewController

@property(nonatomic,strong)NSNumber *vcType;
@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSArray *goodsList;
@end
