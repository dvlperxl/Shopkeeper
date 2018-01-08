//
//  ShoppingListModel.m
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShoppingListModel.h"
#import "ShoppingListHeader.h"

@interface ShoppingListModel ()

@property (nonatomic,strong) NSMutableArray *shoppingList;
@property (nonatomic,strong) NSMutableArray *selectedList;
@property (nonatomic,assign) BOOL changeShopping;
@property (nonatomic,strong) KKTableViewModel *tableViewModel;


@end

@implementation ShoppingListModel

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (ShoppingListCellModel *)updateGoodsCount:(NSNumber *)goodsCount indexPath:(NSIndexPath *)indexPath {
    return [self updateGoodsKey:@"goodsNum" goodsValue:goodsCount indexPath:indexPath];
}
/** 删除商品*/
- (BOOL)deleteGoodsForIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *shop = [self.shoppingList objectAtIndex:indexPath.section];
    if (shop) {
        NSMutableArray *goodsList = shop[@"shopItemList"];
        NSMutableDictionary *goods = [goodsList objectAtIndex:indexPath.row];
        if (goods) {
            if ([self.selectedList containsObject:goods]) {
                [self.selectedList removeObject:goods];
            }
            [goodsList removeObjectAtIndex:indexPath.row];
            if (goodsList.count == 0) {
                [self.shoppingList removeObject:shop];
            }
            [self checkListWhetherEmpty];
            self.changeShopping = YES;
            return YES;
        }
    }
    return NO;
}
/** 选择商品操作*/
- (void)selectedGoodsForIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *shop = [self.shoppingList objectAtIndex:indexPath.section];
    if (shop) {
        NSMutableArray *goodsList = shop[@"shopItemList"];
        NSMutableDictionary *goods = [goodsList objectAtIndex:indexPath.row];
        if (goods) {
            
            if ([self.selectedList containsObject:goods])
            {
                [self.selectedList removeObject:goods];
                
            } else {
                
                [self.selectedList addObject:goods];
            }
        }
    }
}

/** 全选/不全选操作*/
- (void)selectedAll:(BOOL)selected {
//    [self.selectedList removeAllObjects];
//    if (selected) {
//        for (NSMutableDictionary *shop in self.shoppingList) {
//            NSMutableArray *goods = shop[@"shopItemList"];
//            [self.selectedList addObjectsFromArray:goods];
//        }
//    }
    
    for (KKSectionModel *sectionModel in self.tableViewModel.sectionDataList) {
        
        for (KKCellModel *cellModel  in sectionModel.cellDataList) {
            
            ShoppingListCellModel *data = cellModel.data;
            data.select = selected;
        }
    }

    
}
/** 结算操作*/
- (NSMutableArray*)updateShopCarts {
    // 选中商品添加字段
//    for (NSMutableDictionary *goods in self.selectedList) {
//        [goods setObject:@(YES) forKey:@"toBuy"];
//    }
    NSMutableArray *goodsList = @[].mutableCopy;
    
    for (KKSectionModel *sectionModel in self.tableViewModel.sectionDataList) {
        
        NSMutableDictionary *md = @{}.mutableCopy;
        NSMutableArray *goods = @[].mutableCopy;
        ShoppingListHeaderModel *sectionData = (ShoppingListHeaderModel*)sectionModel.headerData.data;
        for (KKCellModel *cellModel  in sectionModel.cellDataList) {
            
            ShoppingListCellModel *data = cellModel.data;
            NSMutableDictionary *dict = data.goods.mutableCopy;
            [dict setObject:@(data.select) forKey:@"toBuy"];
            [dict setObject:data.goodsNumber forKey:@"goodsNum"];
            [goods addObject:dict];
        }
        [md setObject:goods forKey:@"shopItemList"];
        //        [md setObject:goods forKey:@"shopItemList"];
        [md setObject:sectionData.wholesaleId forKey:@"wholesaleId"];
        [md setObject:sectionData.wholesaleName forKey:@"wholesaleName"];
        [goodsList addObject:md];
    }
    return goodsList;
}

- (NSMutableArray*)synchShopCarts
{
    NSMutableArray *goodsList = @[].mutableCopy;

    for (KKSectionModel *sectionModel in self.tableViewModel.sectionDataList) {
        
        NSMutableDictionary *md = @{}.mutableCopy;
        NSMutableArray *goods = @[].mutableCopy;
        ShoppingListHeaderModel *sectionData = (ShoppingListHeaderModel*)sectionModel.headerData.data;
        for (KKCellModel *cellModel  in sectionModel.cellDataList) {
            
            ShoppingListCellModel *data = cellModel.data;
            NSMutableDictionary *dict = data.goods.mutableCopy;
//            [dict setObject:@(data.select) forKey:@"toBuy"];
            [dict setObject:data.goodsNumber forKey:@"goodsNum"];
            [goods addObject:dict];
        }
        [md setObject:goods forKey:@"shopItemList"];
//        [md setObject:goods forKey:@"shopItemList"];
        [md setObject:sectionData.wholesaleId forKey:@"wholesaleId"];
        [md setObject:sectionData.wholesaleName forKey:@"wholesaleName"];
        [goodsList addObject:md];
    }
    return goodsList;
}

/** 取消结算*/
- (void)cancelShopCarts {
//    for (NSMutableDictionary *goods in self.selectedList) {
//        [goods setObject:@(NO) forKey:@"toBuy"];
//    }
}
- (ShoppingListCellModel *)updateGoodsKey:(NSString *)goodsKey goodsValue:(id)value indexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *shop = [self.shoppingList objectAtIndex:indexPath.section];
    if (shop) {
        NSMutableArray *goodsList = shop[@"shopItemList"];
        NSMutableDictionary *goods = [goodsList objectAtIndex:indexPath.row];
        
        if (goods && [goods.allKeys containsObject:goodsKey])
        {
            [goods setObject:value forKey:goodsKey];
            self.changeShopping = YES;
            return [self cellDataWithGoods:goods];
        }
    }
    return nil;
}
/** 是否是全选状态*/
- (BOOL)isSelectedAllStatus {
    return (self.totalGoodsCount == self.selectedList.count && self.selectedList.count > 0);
}
/** 选中商品价格*/
- (NSString*)selectedGoodsPrice {
//    CGFloat price = 0.0;
    NSString *priceStr = @"0.00";
    
    for (KKSectionModel *sectionModel in self.tableViewModel.sectionDataList) {
        
        for (KKCellModel *cellModel  in sectionModel.cellDataList) {
            
            ShoppingListCellModel *data = cellModel.data;
            if (data.select) {
                NSDictionary *goods = data.goods;
                
                NSString *str = [Calculate amountDisplayCalculate:goods[@"goodsPrice"] multiplyingBy:data.goodsNumber];
                if (priceStr)
                {
                    priceStr = [Calculate amountDisplayCalculate:priceStr addBy:str];
                    
                }else
                {
                    priceStr = str;
                }
            }
        }
    }

    
    
    return priceStr;
}
/** 选中商品数量*/
- (NSInteger)selectedGoodsCount {
    return self.selectedList.count;
}
/** 购物车列表*/
- (NSArray *)currentShoppingList {
    if (!self.shoppingList || self.shoppingList.count == 0) {
        return @[];
    }
    return self.shoppingList.copy;
}
/** 是否操作商品*/
- (BOOL)changeShoppingList {
    return self.changeShopping;
}
- (void)inputShoopingListResponse:(NSArray *)responseObject {
    self.shoppingList = [NSJSONSerialization JSONObjectWithData:[responseObject yy_modelToJSONData] options:NSJSONReadingMutableContainers error:nil];
}

- (KKTableViewModel *)tableViewModel {
    
    if (_tableViewModel == nil) {
        KKTableViewModel *tableModel = [KKTableViewModel new];
        [tableModel addSetionModelList:[self sectionModelList]];
        _tableViewModel = tableModel;
    }
    return _tableViewModel;
}

- (NSArray <KKSectionModel *>*)sectionModelList {
    NSMutableArray *sections = @[].mutableCopy;
    if ([self checkListWhetherEmpty]) {
        return @[];
    }
    for (NSDictionary *shop in self.shoppingList) {
        KKSectionModel *sectionModel = [KKSectionModel new];
        NSArray *shopList = shop[@"shopItemList"];
        NSArray *cellModelList = [self cellModelListWithGoodsList:shopList];
        [sectionModel addCellModelList:cellModelList];
        sectionModel.headerData = [self sectionHeaderModelWithShop:shop];
        [sections addObject:sectionModel];
    }
    return sections.copy;
}

- (NSArray <KKCellModel *>*)cellModelListWithGoodsList:(NSArray *)goodsList {
    NSMutableArray *cellModelList = @[].mutableCopy;
    for (NSDictionary *goods in goodsList) {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.cellClass = NSClassFromString(@"ShoppingListCell");
        cellModel.height = 148.0f;
        cellModel.data = [self cellDataWithGoods:goods];
        [cellModelList addObject:cellModel];
    }
    return cellModelList.copy;
}
- (ShoppingListCellModel *)cellDataWithGoods:(NSDictionary *)goods
{
    ShoppingListCellModel *data = [ShoppingListCellModel new];
    data.goodsImage = goods[@"imgUrl"];
    data.goodsContent = goods[@"goodsName"];
    data.goodsSpeci = goods[@"spec"];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithAttributedString:[[NSAttributedString alloc]initWithString:@"¥" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ED8508"],NSFontAttributeName:APPFONT(12)}]];
    NSNumber *price = goods[@"goodsPrice"];
    if (!price) {
        price = @(0.00);
    }
    NSAttributedString *priceAtt = [[NSAttributedString alloc]initWithString:AMOUNTSTRING(price) attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ED8508"],NSFontAttributeName:APPFONT(22)}];
    [att appendAttributedString:priceAtt];
    data.goodsPrice = att.copy;
    data.goodsNumber = goods[@"goodsNum"];
    data.goods = goods;
    
    return data;
}
- (KKCellModel *)sectionHeaderModelWithShop:(NSDictionary *)shop {
    KKCellModel *headerModel = [KKCellModel new];
    headerModel.cellClass = NSClassFromString(@"ShoppingListHeader");
    headerModel.height = 45.0f;
    
    ShoppingListHeaderModel *data = [ShoppingListHeaderModel new];
    data.wholesaleName = shop[@"wholesaleName"];
    data.wholesaleId = shop[@"wholesaleId"];
    headerModel.data = data;
    return headerModel;
}
- (BOOL)checkListWhetherEmpty {
    if (!self.shoppingList || self.shoppingList.count == 0) {
        if (self.listEmpty) {
            self.listEmpty();
        }
        return YES;
    }
    return NO;
}

- (void)setSelectGoods
{
    [self.selectedList removeAllObjects];
    for (KKSectionModel *sectionModel in self.tableViewModel.sectionDataList) {
        
        for (KKCellModel *cellModel  in sectionModel.cellDataList) {
            
            ShoppingListCellModel *data = cellModel.data;
            if (data.select) {
                [self.selectedList addObject:data.goods];
            }
        }
    }
}

#pragma mark - getter
- (NSMutableArray *)selectedList {
    if (!_selectedList) {
        _selectedList = [NSMutableArray array];
    }
    return _selectedList;
}
- (NSInteger)totalGoodsCount {
    if (!self.shoppingList || self.shoppingList.count == 0) {
        return 0;
    }
    NSInteger totalCount = 0;
    for (NSDictionary *shop in self.shoppingList) {
        NSArray *goodsList = shop[@"shopItemList"];
        totalCount += goodsList.count;
    }
    return totalCount;
}
@end
