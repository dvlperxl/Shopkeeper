//
//  ReceivePersonListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ReceivePersonListModel.h"
#import "ReceivePersonListTableViewCell.h"

@interface ReceivePersonListModel ()

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSString *selectAddressId;

@end

@implementation ReceivePersonListModel

- (KKTableViewModel*)tableViewModel:(NSArray*)addressList storeId:(NSNumber*)storeId selectAddressId:(NSString*)addressId
{
    KKTableViewModel *tableViewModel = [[KKTableViewModel alloc]init];
    tableViewModel.noResultImageName = Default_nodata;
    KKSectionModel *section = [KKSectionModel new];
    [tableViewModel addSetionModel:section];
    self.storeId = storeId;
    self.selectAddressId = addressId;
    for (NSDictionary *address in addressList)
    {
        [section addCellModel:[self cellModel:address]];
    }
    return tableViewModel;
}

- (KKCellModel*)cellModel:(NSDictionary*)address
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"ReceivePersonListTableViewCell");

    ReceivePersonListTableViewCellModel *data = [ReceivePersonListTableViewCellModel  new];
    cellModel.data = data;
    data.receiveName = [NSString stringWithFormat:@"收货人：%@",address[@"receivePerson"]];
    data.receivePhone = [NSString stringWithFormat:@"%@",address[@"receivePhone"]];
    
    NSString *fullAddress = address[@"fullAddress"];
//    NSString *area = address[@"area"];
    
    NSMutableString *str = [NSMutableString string];
    NSDictionary * areaDto = address[@"areaDto"];
    [str appendString:areaDto[@"province"]];
    [str appendString:areaDto[@"city"]];
    [str appendString:areaDto[@"district"]];
    NSString *area = str.copy;
    [str appendString:areaDto[@"town"]];
    [str appendString:address[@"village"]];
    [str appendString:address[@"addressDetail"]];

    
    if (fullAddress == nil)
    {
        fullAddress = str.copy;
    }
    
    data.address = fullAddress;
    
    
    NSString *province = [areaDto objectForKey:@"province"];
    NSString *city = [areaDto objectForKey:@"city"];
    NSString *district = [areaDto objectForKey:@"district"];
    NSString *town = [areaDto objectForKey:@"town"];
    NSString *village = address[@"village"];

    NSNumber *areaId = address[@"areaId"];
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
    
    NSMutableDictionary *callBack = @{}.mutableCopy;
    [callBack setObject:address[@"receivePerson"] forKey:@"name"];
    [callBack setObject:address[@"receivePhone"] forKey:@"mobile"];
    [callBack setObject:address[@"id"] forKey:@"addressId"];
    [callBack setObject:fullAddress forKey:@"address"];
    [callBack setObject:address[@"areaDto"] forKey:@"areaInfo"];
    [callBack setObject:address[@"areaId"] forKey:@"areaId"];
    cellModel.routerModel.methodName = @"selectCell:";
    cellModel.routerModel.param = callBack.copy;
    
    if ([address[@"id"] isEqualToString:self.selectAddressId])
    {
        data.select = YES;
    }
    
    RouterModel *editRouterModel = [RouterModel new];
    editRouterModel.className = @"AddReceivePeopleViewController";
    
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:address[@"id"] forKey:@"addressId"];
    
    NSMutableDictionary *md = @{}.mutableCopy;
    [md setDictionary:address];
    [md setObject:area forKey:@"area"];
    [md setObject:areaId forKey:@"areaId"];
    [param setObject:md forKey:@"address"];
    [param setObject:address[@"state"] forKey:@"state"];

    editRouterModel.param = param.copy;
    data.editRouterModel = editRouterModel;
    
    return cellModel;

}

@end
