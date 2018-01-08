//
//  OrderListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderListModel.h"
#import "OrderListTableViewCell.h"
#import "OrderListTableHeaderView.h"



@interface OrderListModel()

@property(nonatomic,copy)NSArray *orderList;
@property(nonatomic,copy)NSString *status;

@end

@implementation OrderListModel

+ (KKTableViewModel *)tableViewModel:(NSArray*)orderList status:(NSString*)status
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_nodata;
    for (NSDictionary *sectionData in orderList)
    {
        [tableViewModel addSetionModel:[self sectionModel:sectionData status:status]];
    }
    
    return tableViewModel;
    
}

+ (KKSectionModel*)sectionModel:(NSDictionary*)sectionData status:(NSString*)status
{
    if ([sectionData[@"data"] count]==0)
    {
        return nil;
    }
    KKSectionModel *sectionModel = [KKSectionModel new];
    
    sectionModel.headerData.cellClass = NSClassFromString(@"OrderListTableHeaderView");
    sectionModel.headerData.height = 50;
    sectionModel.footerData.height = 10;
    
    OrderListTableHeaderViewModel *data = [OrderListTableHeaderViewModel new];
    data.title = sectionData[@"time"];
    data.hideLine = YES;
    sectionModel.headerData.data = data;
    
    for (NSDictionary *cellData in sectionData[@"data"])
    {
        [sectionModel addCellModel:[self cellModel:cellData status:status]];
    }
    return sectionModel;
}

+ (KKCellModel *)cellModel:(NSDictionary*)cellData status:(NSString*)status
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"OrderListTableViewCell");
    cellModel.height = 75.0f;
    
    OrderListTableViewCellModel *dataModel = [OrderListTableViewCellModel new];
    cellModel.data = dataModel;
    dataModel.oid  = cellData[@"id"];
    dataModel.name = cellData[@"customer_nme"];
    
    
    if (status.integerValue == 9) {//退款
        
        dataModel.order =  [NSString stringWithFormat:@"订单号%@",cellData[@"return_no"]];
        dataModel.isRefunds = YES;
        NSNumber *return_amount = cellData[@"return_amount"];
        
        NSString *string = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(return_amount)];
        CMLinkTextViewItem *titleItem = [CMLinkTextViewItem new];
        titleItem.textFont = APPFONT(17);
        titleItem.textColor = ColorWithRGB(108, 183, 59, 1);
        titleItem.textContent = string;
        dataModel.amount  = [titleItem attributeStringNormal];

        
    }else
    {
        dataModel.order = [NSString stringWithFormat:@"订单号%@",cellData[@"retail_no"]];
        NSNumber *final_amount = cellData[@"final_amount"];
        
//        NSDecimalNumber *deci = [NSDecimalNumber  decimalNumberWithDecimal:final_amount.decimalValue];
//        NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithDecimal:[@100.00 decimalValue]];
//        deci = [deci decimalNumberByMultiplyingBy:num];
////        deci = [deci decimalNumberByDividingBy:num];
//        deci = [NSDecimalNumber decimalNumberWithMantissa:deci.longLongValue exponent:-2 isNegative:NO];
//
        NSString *string = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(final_amount)];
        NSLog(@"%@",string);
        CMLinkTextViewItem *titleItem = [CMLinkTextViewItem new];
        titleItem.textFont = APPFONT(17);
        titleItem.textColor = ColorWithRGB(244, 153, 0, 1);
        titleItem.textContent = string;
        dataModel.amount  = [titleItem attributeStringNormal];
    }
    
    
    
    return cellModel;
}



@end
