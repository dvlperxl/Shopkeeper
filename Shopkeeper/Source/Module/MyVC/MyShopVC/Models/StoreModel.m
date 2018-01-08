//
//  StoreModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StoreModel.h"
#import "MyStoreListTableViewCell.h"
#import "AddStoreTableViewCell.h"

@implementation StoreModel

+ (KKTableViewModel *)tableViewModelWithStoreList:(NSArray*)storeList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    
    NSInteger index = 1;
    for (NSDictionary *dict in storeList) {
        
        KKCellModel *cellModel = [KKCellModel new];
        [sectionModel addCellModel:cellModel];
        cellModel.cellClass = [MyStoreListTableViewCell class];
        cellModel.height = 75;
        
        MyStoreListTableViewCellModel *dataModel = [MyStoreListTableViewCellModel new];
        cellModel.data = dataModel;
        dataModel.storeName = dict[@"storeName"];
        dataModel.index = index;
        
        NSDictionary *areaDto = dict[@"areaDto"];
        NSString *province = [areaDto objectForKey:@"province"];
        NSString *city = [areaDto objectForKey:@"city"];
        NSString *district = [areaDto objectForKey:@"district"];
//        NSString *village = [areaDto objectForKey:@"village"];
//        NSString *town = [areaDto objectForKey:@"town"];
//        if (town==nil) {
//            town = @"";
//        }
//        NSString *address = dict[@"address"];
        dataModel.address = [NSString stringWithFormat:@"%@%@%@",province,city,district];
        
        index++;
        
    }
    
    return tableViewModel;
}

+ (NSDictionary*)addStoreParam:(NSDictionary*)dict
{
    NSMutableDictionary *param = @{}.mutableCopy;
    
    NSDictionary *areaDto = dict[@"areaDto"];
    NSString *province = [areaDto objectForKey:@"province"];
    NSString *city = [areaDto objectForKey:@"city"];
    NSString *district = [areaDto objectForKey:@"district"];
    NSString *town = [areaDto objectForKey:@"town"];
    
    NSNumber *storeId = dict[@"id"];
    
    NSString *area = [NSString stringWithFormat:@"%@%@%@",province,city,district];
    
    NSNumber *areaId = dict[@"areaId"];
    NSString *village = dict[@"village"];
    NSString *areaIdStr = STRINGWITHOBJECT(areaId);
    
    
    if (areaIdStr.length==10)
    {
        area = [NSString stringWithFormat:@"%@%@%@%@",province,city,district,town];
        areaId = @(areaIdStr.longLongValue/100);

    }else
    {
        
        if (village == nil || town == nil)
        {
            areaId = @(areaIdStr.longLongValue/100);

        }
        
        if (village == nil) {
            
            village = town;
        }
        
        
        if (village&&town) {
            area = [NSString stringWithFormat:@"%@%@%@%@",province,city,district,town];
        }
        
    }
    
//    areaId = @areaId.integerValue/100);
//    NSNumber *villageId = dict[@"areaId"];
    NSString *address = dict[@"address"];
    NSString *storeName = dict[@"storeName"];
    
    [param setObject:storeId forKey:@"storeId"];
    [param setObject:area forKey:@"area"];
    [param setObject:areaId forKey:@"areaId"];
    [param setObject:village forKey:@"village"];
//    [param setObject:villageId forKey:@"villageId"];
    [param setObject:address forKey:@"address"];
    [param setObject:storeName forKey:@"storeName"];
    
    return param.copy;
}

+ (NSDictionary*)getSaveStoreParam:(KKTableViewModel*)tableView
{
    NSMutableDictionary *param = @{}.mutableCopy;
    KKSectionModel *section = tableView.sectionDataList.firstObject;
    for (KKCellModel *cellModel in section.cellDataList)
    {
        AddStoreTableViewCellModel *dataModel = (AddStoreTableViewCellModel*)cellModel.data;
        [param setObject:dataModel.content forKey:dataModel.contentKey];
    }
    return param;
}

@end
