//
//  MemberShoppingModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/25.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberShoppingModel.h"
#import "OrderListTableViewCell.h"
#import "OrderListTableHeaderView.h"

@interface MemberShoppingModel ()

@property(nonatomic,copy)NSArray *orderList;

@end

@implementation MemberShoppingModel

+ (KKTableViewModel *)tableViewModel:(NSArray*)orderList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    
    for (NSDictionary *sectionData in orderList)
    {
        [tableViewModel addSetionModel:[self sectionModel:sectionData]];
    }
    
    return tableViewModel;
}


+ (KKSectionModel*)sectionModel:(NSDictionary*)sectionData
{
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
        [sectionModel addCellModel:[self cellModel:cellData]];
    }
    return sectionModel;
}

+ (KKCellModel *)cellModel:(NSDictionary*)cellData
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"OrderListTableViewCell");
    cellModel.height = 75.0f;
    
    OrderListTableViewCellModel *dataModel = [OrderListTableViewCellModel new];
    cellModel.data = dataModel;
//    dataModel.oid  = cellData[@"id"];
    dataModel.name = [NSString stringWithFormat:@"订单号%@",cellData[@"retail_no"]];
    dataModel.order = cellData[@"time"];
    
    NSNumber *final_amount = cellData[@"final_amount"];
    
    NSString *string = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(final_amount)];
    NSLog(@"%@",string);
    CMLinkTextViewItem *titleItem = [CMLinkTextViewItem new];
    titleItem.textFont = APPFONT(17);
    titleItem.textColor = ColorWithRGB(244, 153, 0, 1);
    titleItem.textContent = string;
    dataModel.amount  = [titleItem attributeStringNormal];
    
    
    
    return cellModel;
}


@end
