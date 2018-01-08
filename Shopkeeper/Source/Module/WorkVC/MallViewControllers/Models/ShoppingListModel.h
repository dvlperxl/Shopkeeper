//
//  ShoppingListModel.h
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingListCell.h"

typedef void(^ShoppingListModelEmpty)(void);
@interface ShoppingListModel : NSObject

@property (nonatomic,copy) ShoppingListModelEmpty listEmpty;
- (void)inputShoopingListResponse:(NSArray *)responseObject;
- (KKTableViewModel *)tableViewModel;
/** 是否是全选状态*/
- (BOOL)isSelectedAllStatus;
/** 选中商品价格*/
- (NSString*)selectedGoodsPrice;
/** 选中商品数量*/
- (NSInteger)selectedGoodsCount;
/** 购物车列表*/
- (NSArray *)currentShoppingList;
/** 是否操作商品*/
- (BOOL)changeShoppingList;

/** 修改商品数量*/
- (ShoppingListCellModel *)updateGoodsCount:(NSNumber *)goodsCount indexPath:(NSIndexPath *)indexPath;
/** 删除商品*/
- (BOOL)deleteGoodsForIndexPath:(NSIndexPath *)indexPath;
/** 选择商品操作*/
- (void)selectedGoodsForIndexPath:(NSIndexPath *)indexPath;
/** 全选/不全选操作*/
- (void)selectedAll:(BOOL)selected;
/** 结算操作*/
- (NSMutableArray*)updateShopCarts;

/** 同步操作*/
- (NSMutableArray*)synchShopCarts;

/** 取消结算*/
- (void)cancelShopCarts;

- (void)setSelectGoods;

@end
