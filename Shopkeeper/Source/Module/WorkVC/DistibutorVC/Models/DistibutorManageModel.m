//
//  DistibutorManageModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorManageModel.h"
#import "OrderListTableHeaderView.h"
#import "DistibutorOrderListCell.h"

@interface DistibutorManageModel ()

@property(nonatomic,strong)KKTableViewModel *tableViewModel;

@end

@implementation DistibutorManageModel

- (KKTableViewModel*)tableViewModel:(NSArray*)orderList
{
    if (![orderList isKindOfClass:[NSArray class]])
    {
        return self.tableViewModel;
    }
    NSArray *groupList = [self group:[DistibutorOrderListInfo modelObjectListWithArray:orderList] key:@"date"];
    
    for (NSDictionary *group in groupList) {

        NSString *sctionType = group[@"date"];
        KKSectionModel *sectionModel = [self sectionModelWithSectionType:sctionType];
        NSArray *result = group[@"result"];
        for (DistibutorOrderListInfo *info in result)
        {
            [sectionModel addCellModel:[info cellModel]];
        }
    }
    
    return self.tableViewModel;
    
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
        NSString *value = [dict valueForKeyPath:key];
        
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

@implementation DistibutorOrderListInfo

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uid":@"id"};
}

-(NSString *)date
{
    if (!_date) {
        
        if (self.insertTime&&self.insertTime.length>9)
        {
            _date = [self.insertTime substringToIndex:10];
        }
    }
    return _date;
}

- (KKCellModel*)cellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"DistibutorOrderListCell");
    cellModel.height = 75;
    
    DistibutorOrderListCellModel *data = [DistibutorOrderListCellModel new];
    data.title = self.wholesaleName;
    data.desc = [NSString stringWithFormat:@"订单号%@",self.retailNo];
    data.amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.finalAmount)];
    data.imageName = self.deliverMethond == 1?@"icon_self":@"icon_tohome";
    cellModel.data = data;
    
    cellModel.routerModel.className = @"DistibutorOrderDetailViewController";
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setObject:self.uid forKey:@"retailNo"];
    cellModel.routerModel.param = md.copy;
    
    return cellModel;
}

@end
