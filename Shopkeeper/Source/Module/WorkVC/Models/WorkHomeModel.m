//
//  WorkHomeModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "WorkHomeModel.h"
#import "WorkHomeTableViewCell.h"

@interface WorkHomeModel ()

@end

@implementation WorkHomeModel

- (BOOL)showMallToastForStoreId:(NSNumber *)storeId {
    NSDictionary *showMallDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"showMallDic"];
    if (!showMallDic) {
        return YES;
    }
    NSString *key = [self stringStoreIdWithStoreId:storeId];
    NSNumber *hasShow = [showMallDic objectForKey:key];
    return ![hasShow boolValue];
    
    return NO;
}
- (void)hasShowMallToastForStoreId:(NSNumber *)storeId {
    NSDictionary *showMallDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"showMallDic"];
    NSMutableDictionary *md = @{}.mutableCopy;
    if ([showMallDic isKindOfClass:[NSDictionary class]])
    {
        [md setDictionary:showMallDic];
    }
    NSString *key = [self stringStoreIdWithStoreId:storeId];
    [md setObject:@(YES) forKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:md forKey:@"showMallDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)stringStoreIdWithStoreId:(NSNumber *)storeId {
    if (!storeId) {
        return nil;
    }
    if ([storeId isKindOfClass:[NSNumber class]]) {
        return [storeId stringValue];
    }
    if ([storeId isKindOfClass:[NSString class]]) {
        return (NSString *)storeId;
    }
    return nil;
}
- (KKTableViewModel *)workHomeTableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    [tableViewModel addSetionModel:[self bannerSectionModel]];
    [tableViewModel addSetionModel:[self menuSectionModel]];
    return tableViewModel;
}

- (KKSectionModel *)bannerSectionModel
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    KKCellModel *cellModel = [KKCellModel alloc];
    cellModel.height = (SCREEN_WIDTH -10)*320/730+12;
    cellModel.cellClass = NSClassFromString(@"WorkHomeBannerCell");
    [sectionModel addCellModel:cellModel];
    return sectionModel;
}

- (KKSectionModel *)menuSectionModel
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    sectionModel.headerData.cellClass = NSClassFromString(@"WorkHomeSectionHeaderView");
    sectionModel.headerData.height = 35.0f;
    
    NSArray *menuData = [self menuData];
    
    for (NSInteger i = 0; i<menuData.count; i++)
    {
        NSArray *menuList =menuData[i];
        
        KKCellModel *cellModel1 = [[KKCellModel alloc]init];
        cellModel1.cellClass = NSClassFromString(@"WorkHomeTableViewCell");
        cellModel1.height = 100;
        NSMutableArray *menus = @[].mutableCopy;
        for (NSInteger j = 0; j<menuList.count; j++)
        {
            WorkHomeItemViewModel *model = [WorkHomeItemViewModel new];
            NSDictionary *menu = menuList[j];
            model.title = menu[@"title"];
            model.iconName = menu[@"iconName"];
            model.actionName = menu[@"actionName"];
            
            if ([model.title isEqualToString:@"采购商城"])
            {
                if (self.hasPurchaseMall == NO)
                {
                    continue;
                }
                
                model.showTips = self.showTips;
            }
            
            [menus addObject:model];
        }
        cellModel1.data = menus;
        [sectionModel addCellModel:cellModel1];
    }
    return sectionModel;
}

- (NSArray*)menuData
{
    
    NSMutableArray *menus = @[@{@"title":@"销售管理",@"iconName":@"work_home_menu_0",@"actionName":@"TradeManageHomeViewController"},
                              @{@"title":@"进货管理",@"iconName":@"icon_stock",@"actionName":@"StockManageViewController"},
                              @{@"title":@"会员管理",@"iconName":@"work_home_menu_1",@"actionName":@"MemberListViewController"},
                              @{@"title":@"商品管理",@"iconName":@"work_home_goods",@"actionName":@"CommodityListViewController"},
                              @{@"title":@"处方套餐",@"iconName":@"work_home_sets",@"actionName":@"RecipePackageListViewController"},
                              @{@"title":@"公告管理",@"iconName":@"work_home_menu_2",@"actionName":@"NoticeListViewController"},
                              @{@"title":@"经营分析",@"iconName":@"work_home_menu_3",@"actionName":@"BusinessAnalysisHomeViewController"},
                              ].mutableCopy;
    
    if (self.hasPurchaseMall) {
        
        [menus addObject:@{@"title":@"采购商城",@"iconName":@"icon_market",@"actionName":@"MallHomeViewController"}];
    }
    [menus addObject:                              @{@"title":@"分销订单",@"iconName":@"ico_distribution",@"actionName":@"DistibutorManageViewController"}
     ];
    
    
    NSMutableArray *menusGroup = @[].mutableCopy;
    
    while (menus.count>0) {
        
        NSArray *sub;
        if (menus.count>3)
        {
            sub = [menus subarrayWithRange:NSMakeRange(0, 4)];
            [menus removeObjectsInRange:NSMakeRange(0, 4)];
            
        }else
        {
            sub = [menus subarrayWithRange:NSMakeRange(0, menus.count)];
            [menus removeObjectsInRange:NSMakeRange(0, menus.count)];
        }
        
        [menusGroup addObject:sub];
    }
    
    return menusGroup.mutableCopy;
    
}


@end
