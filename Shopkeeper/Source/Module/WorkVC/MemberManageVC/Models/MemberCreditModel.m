//
//  MemberCreditModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberCreditModel.h"
#import "OrderListTableViewCell.h"

@implementation MemberCreditModel

+ (KKTableViewModel *)tableViewModel:(NSArray*)orderList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    
    for (NSDictionary *cellData in orderList)
    {
        [sectionModel addCellModel:[self cellModel:cellData]];
    }
    
    return tableViewModel;
}




+ (KKCellModel *)cellModel:(NSDictionary*)cellData
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"OrderListTableViewCell");
    cellModel.height = 75.0f;
    
    OrderListTableViewCellModel *dataModel = [OrderListTableViewCellModel new];
    cellModel.data = dataModel;
    
    dataModel.order = cellData[@"payDate"];
    
    NSNumber *type = cellData[@"type"];
    if (type.integerValue == 0)
    {
        dataModel.name = [NSString stringWithFormat:@"订单号%@",cellData[@"retailNo"]];
        NSNumber *final_amount = cellData[@"creditAmount"];
        NSString *string = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(final_amount)];
        CMLinkTextViewItem *titleItem = [CMLinkTextViewItem new];
        titleItem.textFont = APPFONT(17);
        titleItem.textColor = ColorWithRGB(244, 153, 0, 1);
        titleItem.textContent = string;
        dataModel.amount  = [titleItem attributeStringNormal];
        
    }else
    {
        dataModel.name = @"赊账还款";
        NSNumber *final_amount = cellData[@"creditAmount"];
        NSString *string = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(final_amount)];
        CMLinkTextViewItem *titleItem = [CMLinkTextViewItem new];
        titleItem.textFont = APPFONT(17);
        titleItem.textColor = ColorWithHex(@"bdca62");
        titleItem.textContent = string;
        dataModel.amount  = [titleItem attributeStringNormal];
    }
    

    
    
    
    return cellModel;
}

@end
