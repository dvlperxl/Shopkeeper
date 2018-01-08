//
//  StockOrderDetailModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "StockOrderDetailModel.h"
#import "OrderDetailMerchandiseCell.h"
#import "GoodsCountTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "OrderListTableHeaderView.h"
#import "StockOrderDetailHeaderView.h"

@implementation StockOrderDetailModel

+ (KKTableViewModel*)tableViewModel:(NSDictionary*)orderDetail tag:(NSNumber *)tag status:(NSString*)status
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.headerViewModel = [self headerViewModel:orderDetail tag:tag status:status];
    
    NSArray *goodsList = orderDetail[@"details"];
    NSDictionary *purchase = orderDetail[@"purchase"];
    if (tag.integerValue == 1) {
        goodsList = orderDetail[@"goodsList"];
        purchase = orderDetail;
    }
    
    KKSectionModel *detailSection = [self detailSectionModel:goodsList tag:tag];
    [detailSection addCellModel:[self totalAmountCellModel:orderDetail tag:tag]];
    [tableViewModel addSetionModel:detailSection];
    [tableViewModel addSetionModel:[self finalAmountSectionModel:purchase tag:tag]];
    
    return tableViewModel;
}

+ (StockOrderDetailHeaderViewModel*)headerViewModel:(NSDictionary*)orderDetail tag:(NSNumber*)tag status:(NSString*)status
{
    StockOrderDetailHeaderViewModel*model = [StockOrderDetailHeaderViewModel new];
    
    if (tag.integerValue == 0) {
        
        model.title = orderDetail[@"supplier"][@"contactName"];
        model.mobile = orderDetail[@"supplier"][@"contactPhone"];
        model.orderTime = orderDetail[@"purchase"][@"purchaseDate"];
        model.orderNo = orderDetail[@"purchase"][@"purchaseNo"];

    }else
    {
        model.title = orderDetail[@"wholesaleName"];
        model.mobile = orderDetail[@"wholeSalePhone"];
        model.orderTime = orderDetail[@"date"];
        model.orderNo = orderDetail[@"retailNo"];
    }
    
    NSString *statusStr = @"已退货";
    if ([status isEqualToString:@"3"])
    {
        statusStr = @"已收货";
    }
    
    if ([status isEqualToString:@"2"]) {
        statusStr = @"待收货";
    }
    
    model.orderStatus = statusStr;
    
    return model;
}

+(KKSectionModel*)detailSectionModel:(NSArray*)details tag:(NSNumber*)tag
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    sectionModel.footerData.height = 10;
    sectionModel.headerData.height = 50;
    sectionModel.headerData.cellClass = NSClassFromString(@"OrderListTableHeaderView");
    OrderListTableHeaderViewModel *data = [OrderListTableHeaderViewModel new];
    data.title = @"产品信息";
    data.hideLine = NO;
    sectionModel.headerData.data = data;
    for (NSDictionary * detail in details)
    {
        [sectionModel addCellModel:[self goodsCellModel:detail tag:tag]];
    }
    return sectionModel;
}


+ (KKCellModel*)goodsCellModel:(NSDictionary*)goods tag:(NSNumber*)tag
{
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"OrderDetailMerchandiseCell");
    OrderDetailMerchandiseCellModel *data = [OrderDetailMerchandiseCellModel new];
    
    data.name = goods[@"goods_name"];
    data.brand = goods[@"goods_brand"];
    data.desc = goods[@"goods_speci"];
    
    NSString *amount = AMOUNTSTRING(goods[@"purchase_price"]);
    NSNumber *number = goods[@"purchase_num"];
    
    if (tag.integerValue == 1) {
     
        data.name = goods[@"goodsName"];
        data.brand = goods[@"goodsBrand"];
        data.desc = goods[@"goodsSpeci"];
        
        amount = AMOUNTSTRING(goods[@"goodsPrice"]);
        number = goods[@"goodsNum"];
    }
    
    cell.height = [data.name calculateHeight:CGSizeMake(SCREEN_WIDTH-120, 200) font:APPFONT(17)]+55;
    
    data.amount = amount;
    data.count = STRING(@"x", number);
    cell.data = data;
    return cell;
}


+ (KKCellModel*)totalAmountCellModel:(NSDictionary*)orderDetail tag:(NSNumber *)tag
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 50;
    cellModel.cellType = @"goodsCount";
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    
    NSArray *details = orderDetail[@"details"];
    if (tag.integerValue == 1) {
        
        details = orderDetail[@"goodsList"];
        
    }
    data.title = [NSString stringWithFormat:@"共%@件商品",@(details.count)];
    NSDictionary *purchase = orderDetail[@"purchase"];
    NSString *totalAmount = purchase[@"totalAmount"];
    
    if (tag.integerValue == 1) {
        totalAmount = orderDetail[@"totalAmount"];
    }
    
    totalAmount = AMOUNTSTRING(totalAmount);
        NSString *total = STRING(@"合计:¥",totalAmount);
    data.amount = [CMLinkTextViewItem attributeStringWithText:total textFont:APPFONT(17) textColor: ColorWithHex(@"#333333") textAlignment:NSTextAlignmentRight];
    cellModel.data = data;
    return cellModel;
}



+ (KKSectionModel*)finalAmountSectionModel:(NSDictionary*)purchase tag:(NSNumber*)tag
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = @"结算金额";
    
    NSString *totalAmount = purchase[@"finalAmount"];
    NSString *creditAmount = purchase[@"creditAmount"];
    
    if (tag.integerValue == 1) {
        
        totalAmount = purchase[@"totalAmount"];
    }
    
    double prepay = totalAmount.doubleValue - creditAmount.doubleValue;
    NSString *prepayAmount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(@(prepay))];
    creditAmount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(creditAmount)];
    totalAmount = [NSString stringWithFormat:@"%@",AMOUNTSTRING(totalAmount)];
    NSAttributedString *str = [CMLinkTextViewItem attributeStringWithText:@"¥" textFont:APPFONT(17) textColor: ColorWithHex(@"#ED8508") textAlignment:NSTextAlignmentRight];
    NSAttributedString *str1 = [CMLinkTextViewItem attributeStringWithText:totalAmount textFont:APPFONT(30) textColor: ColorWithHex(@"#ED8508") textAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    [mStr appendAttributedString:str1];
    data.amount = mStr;
    cellModel.data = data;
    
    [sectionModel addCellModel:cellModel];
    
    if (tag.integerValue == 0) {
        
        //赊账金额
        KKCellModel *cellModel2 = [KKCellModel new];
        cellModel2.cellClass = NSClassFromString(@"RemarkTableViewCell");
        RemarkTableViewCellModel *data2 = [RemarkTableViewCellModel new];
        data2.title = [CMLinkTextViewItem attributeStringWithText:@"赊账金额" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
        data2.content = [CMLinkTextViewItem attributeStringWithText:creditAmount textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
        cellModel2.data = data2;
        [sectionModel addCellModel:cellModel2];
    }

    
    //已收金额
    KKCellModel *cellModel1 = [KKCellModel new];
    cellModel1.cellClass = NSClassFromString(@"RemarkTableViewCell");
    RemarkTableViewCellModel *data1 = [RemarkTableViewCellModel new];
    data1.title = [CMLinkTextViewItem attributeStringWithText:@"已收金额" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
    data1.content = [CMLinkTextViewItem attributeStringWithText:prepayAmount textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
    cellModel1.data = data1;
    [sectionModel addCellModel:cellModel1];
    
    //结算方式
    
    KKCellModel *cellModel4 = [KKCellModel new];
    cellModel4.cellClass = NSClassFromString(@"RemarkTableViewCell");
    RemarkTableViewCellModel *data4 = [RemarkTableViewCellModel new];
    data4.title = [CMLinkTextViewItem attributeStringWithText:@"结算方式" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
    
    data4.content = [CMLinkTextViewItem attributeStringWithText:purchase[@"method"] textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
    cellModel4.data = data4;
    [sectionModel addCellModel:cellModel4];
    
    if (tag.integerValue == 0) {
        
        //备注
        NSString *remark = purchase[@"remark"];
        if (remark == nil||remark.length<1)
        {
            remark = @"暂无备注信息";
        }
        KKCellModel *cellModel3 = [KKCellModel new];
        cellModel3.cellClass = NSClassFromString(@"RemarkTableViewCell");
        RemarkTableViewCellModel *data3 = [RemarkTableViewCellModel new];
        data3.title = [CMLinkTextViewItem attributeStringWithText:@"备注" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
        data3.content = [CMLinkTextViewItem attributeStringWithText:remark textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
        cellModel3.data = data3;
        [sectionModel addCellModel:cellModel3];
        
    }
    
    return sectionModel;
}



@end
