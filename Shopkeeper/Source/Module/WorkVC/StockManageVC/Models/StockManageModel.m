//
//  StockManageModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//  

#import "StockManageModel.h"
#import "StockManageTableViewCell.h"
#import "OrderListTableHeaderView.h"

@interface StockManageModel ()

@property(nonatomic,strong)KKTableViewModel *tableViewModel;

@end

@implementation StockManageModel

- (KKTableViewModel*)tableViewModelInsertDataList:(NSArray*)dataList
{
    if (![dataList isKindOfClass:[NSArray class]])
    {
        return self.tableViewModel;
    }
    NSArray *groupList = [self group:dataList key:@"date"];
    
    for (NSDictionary *group in groupList) {
        
        NSString *sctionType = group[@"date"];
        KKSectionModel *sectionModel = [self sectionModelWithSectionType:sctionType];
        NSArray *result = group[@"result"];
        for (NSDictionary *dict in result)
        {
            [sectionModel addCellModel:[self cellModel:dict]];
        }
    }
    
    return self.tableViewModel;
}

- (KKCellModel*)cellModel:(NSDictionary*)dict
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"StockManageTableViewCell");
    cellModel.height = 75;
    
    StockManageTableViewCellModel *data = [StockManageTableViewCellModel new];
    data.title = dict[@"wholesaleName"];
    
    NSString *orderNo = dict[@"retailNo"];
    if (orderNo == nil) {
        
        orderNo = dict[@"returnNo"];
    }
    
    data.desc = STRING(@"订单号", orderNo);
    
    NSNumber *totalAmount = dict[@"totalAmount"];
    if (totalAmount == nil) {
        totalAmount = dict[@"returnAmount"];
    }
    
    data.amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(totalAmount)];
    cellModel.data = data;
    
    if (self.fromType.integerValue == 1)
    {
        cellModel.routerModel.className = @"StockOrderDetailViewController";
        NSMutableDictionary *md = @{}.mutableCopy;
        [md setObject:dict[@"storePurchaseId"] forKey:@"orderId"];
        if (dict[@"wholesaleReturnId"]) {
            [md setObject:dict[@"wholesaleReturnId"] forKey:@"orderId"];
        }
        
        if (self.status.integerValue == 2)
        {
            if (dict[@"wholeSaleRetailId"]) {
                [md setObject:dict[@"wholeSaleRetailId"] forKey:@"orderId"];
            }
        }

        NSNumber *tag = dict[@"tag"];
        if (tag == nil) {
            tag = @1;
        }
        [md setObject:tag forKey:@"tag"];
        [md setObject:self.status forKey:@"status"];
        [md setObject:self.storeId forKey:@"storeId"];
        cellModel.routerModel.param = md.copy;
        
    }else
    {
        NSString *wholeSaleRetailId = dict[@"wholeSaleRetailId"];
        if (wholeSaleRetailId == nil) {
            
            wholeSaleRetailId = dict[@"returnId"];
        }
        cellModel.routerModel.className = @"MallOrderDetailViewController";
        NSMutableDictionary *md = @{}.mutableCopy;
        [md setObject:wholeSaleRetailId forKey:@"wholeSaleRetailId"];
        [md setObject:self.storeId forKey:@"storeId"];
        [md setObject:self.status forKey:@"status"];
        cellModel.routerModel.param = md.copy;
        data.status = self.status;

    }
    return cellModel;
}

- (KKSectionModel*)sectionModelWithSectionType:(NSString*)sectionType
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"sectionType = %@",sectionType];
    NSArray *res = [self.tableViewModel.sectionDataList.copy filteredArrayUsingPredicate:pred];
    if (res.count>0) {
        
        sectionModel = res.lastObject;
        
    }else
    {
        sectionModel = [KKSectionModel new];
        sectionModel.sectionType = sectionType;
        sectionModel.footerData.height = 10;
        sectionModel.headerData.height = 50;
        sectionModel.headerData.cellClass = NSClassFromString(@"OrderListTableHeaderView");
        OrderListTableHeaderViewModel *data = [OrderListTableHeaderViewModel new];
        data.title = sectionType;
        data.hideLine = YES;
        sectionModel.headerData.data = data;
        [self.tableViewModel addSetionModel:sectionModel];
    }
    return sectionModel;
}


- (NSArray*)group:(NSArray*)dataList key:(NSString*)key
{
    NSMutableArray *group = @[].mutableCopy;
    
    for (NSDictionary *dict in dataList)
    {
        NSString *value = dict[key];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"date = %@",value];
        NSArray *res = [group.copy filteredArrayUsingPredicate:pred];
        
        if (res.count>0)
        {
            NSMutableDictionary *md = res.lastObject;
            NSMutableArray *result = md[@"result"];
            [result addObject:dict];
            
        }else
        {
            NSMutableDictionary *md = @{}.mutableCopy;
            NSMutableArray *result = @[].mutableCopy;
            [result addObject:dict];
            [md setObject:value forKey:key];
            [md setObject:result forKey:@"result"];
            [group addObject:md];
        }
    }
    
    return group.copy;
}

- (KKTableViewModel *)tableViewModel
{
    if (!_tableViewModel)
    {
        _tableViewModel = [KKTableViewModel new];
        _tableViewModel.noResultImageName = Default_nodata;
    }
    return _tableViewModel;
}

@end
