//
//  SMSRechargeListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRechargeListModel.h"
#import "SMSRechargeListCell.h"

@implementation SMSRechargeListModel

+ (KKTableViewModel *)tableViewModel:(NSArray*)orderList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_nodata;
    KKSectionModel *sectionModel = [KKSectionModel new];
    sectionModel.footerData.height = 10;
    [tableViewModel addSetionModel:sectionModel];
    
    for (NSDictionary *order in orderList) {
        
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.cellClass = NSClassFromString(@"SMSRechargeListCell");
        cellModel.height = 75;
        SMSRechargeListCellModel *data = [SMSRechargeListCellModel new];
        data.date = order[@"insertTime"];
        data.payType = order[@"method"];
        data.amout = STRING(@"¥", AMOUNTSTRING(order[@"amount"]));
        cellModel.data = data;
        [sectionModel addCellModel:cellModel];
    }
    
    return tableViewModel;
}
@end
