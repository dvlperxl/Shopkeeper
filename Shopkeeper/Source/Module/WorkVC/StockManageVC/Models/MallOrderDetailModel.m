//
//  MallOrderDetailModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderDetailModel.h"
#import "OrderDetailAddressTableViewCell.h"
#import "OrderListTableHeaderView.h"
#import "MallOrderdetailMerchandiseCell.h"
#import "GoodsCountTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "StockOrderDetailHeaderView.h"


@interface MallOrderDetailModel ()

@property(nonatomic,assign)double totalAmout;

@end

@implementation MallOrderDetailModel

- (KKTableViewModel*)mallOrdetailTableViewModel:(NSDictionary*)orderDetail
{
    self.totalAmout = 0;
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    [tableViewModel addSetionModel:[self addressSection:orderDetail]];
    [tableViewModel addSetionModel:[self detailSectionModel:orderDetail[@"goodsList"]]];
    [tableViewModel addSetionModel:[self finalAmountSectionModel:orderDetail]];
    tableViewModel.headerViewModel = [self headerViewModel:orderDetail];
    return tableViewModel;
}

- (StockOrderDetailHeaderViewModel*)headerViewModel:(NSDictionary*)orderDetail
{
    StockOrderDetailHeaderViewModel*model = [StockOrderDetailHeaderViewModel new];
    
    model.title = orderDetail[@"wholesaleName"];
    model.mobile = orderDetail[@"wholeSalePhone"];
    model.orderTime = orderDetail[@"insertTime"];
    
    NSString *orderNo = orderDetail[@"retailNo"];
    if (orderNo == nil) {
        orderNo = orderDetail[@"returnNo"];
    }
    model.orderNo = orderNo;
    //todo
    NSString *status = orderDetail[@"retailStatus"];
    NSString *statusStr = @"退货";
    if ([status isEqualToString:@"1"])
    {
        statusStr = @"待确认";
        
    }else if ([status isEqualToString:@"2"])
    {
        statusStr = @"待收货";

    }else if ([status isEqualToString:@"3"])
    {
        statusStr = @"已收货";
        
    }else if ([status isEqualToString:@"7"])
    {
        statusStr = @"待支付";
    }
    
    model.orderStatus = statusStr;
    
    return model;
}


- (KKSectionModel*)addressSection:(NSDictionary*)orderDetail
{
    KKSectionModel*section = [KKSectionModel new];
    section.footerData.height = 10;
    KKCellModel *cellModel = [KKCellModel new];
    [section addCellModel:cellModel];
    
    cellModel.cellClass = NSClassFromString(@"OrderDetailAddressTableViewCell");
    OrderDetailAddressTableViewCellModel *data = [OrderDetailAddressTableViewCellModel new];
    NSDictionary *address = orderDetail[@"address"];
    
    if (address)
    {
        data.name = STRING(@"收货人：",address[@"receivePerson"]);
        data.mobile = address[@"receivePhone"];
        data.address = STRING(@"收货地址：", address[@"fullAddress"]);
        
    }else
    {
        data.name = STRING(@"收货人：",orderDetail[@"receiveName"]);
        data.mobile = orderDetail[@"receivePhone"];
        data.address = STRING(@"收货地址：",orderDetail[@"receiveAddress"]) ;
    }

    cellModel.data = data;
    return section;
}

-(KKSectionModel*)detailSectionModel:(NSArray*)details
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
        [sectionModel addCellModel:[self goodsCellModel:detail]];
    }
    [sectionModel addCellModel:[self totalAmountCellModel:details]];
    return sectionModel;
}

- (KKCellModel*)goodsCellModel:(NSDictionary*)goods
{
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"MallOrderdetailMerchandiseCell");
    MallOrderdetailMerchandiseCellModel *data = [MallOrderdetailMerchandiseCellModel new];
    data.imageUrl = goods[@"goodsImageUrl"];
    
    NSMutableString *title = [NSMutableString string];
    NSString *goodsBrand = [NSString stringWithFormat:@"[%@]",goods[@"goodsBrand"]];
    [title appendString:goodsBrand];
    [title appendString:@"  "];
    [title appendString:goods[@"goodsName"]];
    [title appendString:@"  "];
    [title appendString:goods[@"content"]];
    [title appendString:goods[@"contentUnit"]];    
    
    if (goods[@"nitrogen"])
    {
        [title appendString:@"  "];
        [title appendString:goods[@"nitrogen"]];
        [title appendString:@"-"];

    }
    
    if (goods[@"phosphorus"])
    {
        [title appendString:goods[@"phosphorus"]];
        [title appendString:@"-"];

    }
    
    if (goods[@"potassium"])
    {
        [title appendString:goods[@"potassium"]];
    }
    
    if ([title hasSuffix:@"-"])
    {
        [title deleteCharactersInRange:NSMakeRange(title.length-1, 1)];
    }

    data.title = title;
    

    NSMutableString *spec = [NSMutableString string];
    if (goods[@"goodsWrapNum"])
    {
        [spec appendString:goods[@"goodsSpeciNum"]];
        [spec appendString:goods[@"goodsSpeciUnit1"]];
        [spec appendString:@"*"];
        [spec appendString:goods[@"goodsWrapNum"]];
        [spec appendString:goods[@"goodsSpeciUnit2"]];
        [spec appendString:@"/"];
        [spec appendString:goods[@"goodsWrapUnit"]];
    }else
    {
        [spec appendString:goods[@"goodsSpeci"]];
    }

    data.spec = spec.copy;
    
    NSNumber *goodsWrapSalePrice = goods[@"retailPrice"];
    NSNumber *number = goods[@"retailNum"];
    if (number == nil)
    {
        number = goods[@"returnNum"];
        goodsWrapSalePrice = goods[@"returnPrice"];
    }
    
    data.price = [NSString stringWithFormat:@"单价¥%@",AMOUNTSTRING(goodsWrapSalePrice)];
    data.count = STRING(@"x", number);
    
    NSAttributedString *item1 = [CMLinkTextViewItem attributeStringWithText:@"应付款：¥" textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")];
    double yfAmout = goodsWrapSalePrice.doubleValue * number.integerValue;
    self.totalAmout+=yfAmout;
    NSString *yfStr = AMOUNTSTRING(@(yfAmout));
    NSAttributedString *item2 = [CMLinkTextViewItem attributeStringWithText:yfStr textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]init];
    [aStr appendAttributedString:item1];
    [aStr appendAttributedString:item2];
    
    data.total = aStr;
    cell.data = data;
    return cell;
}

- (KKCellModel*)totalAmountCellModel:(NSArray*)goodsList
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 50;
    cellModel.cellType = @"goodsCount";
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = [NSString stringWithFormat:@"共%@件商品",@(goodsList.count)];
    NSString *totalAmount = AMOUNTSTRING(@(self.totalAmout));
    NSString *total = STRING(@"合计：¥",totalAmount);
    data.amount = [CMLinkTextViewItem attributeStringWithText:total textFont:APPFONT(17) textColor: ColorWithHex(@"#333333") textAlignment:NSTextAlignmentRight];
    cellModel.data = data;
    return cellModel;
}

- (KKSectionModel*)finalAmountSectionModel:(NSDictionary*)purchase
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = @"订单总金额";
    NSString *totalAmount = purchase[@"totalAmount"];
    if (totalAmount == nil) {
        totalAmount = purchase[@"returnAmount"];
    }
    totalAmount = AMOUNTSTRING(totalAmount);
    NSAttributedString *str = [CMLinkTextViewItem attributeStringWithText:@"¥" textFont:APPFONT(17) textColor: ColorWithHex(@"#ED8508") textAlignment:NSTextAlignmentRight];
    NSAttributedString *str1 = [CMLinkTextViewItem attributeStringWithText:totalAmount textFont:APPFONT(30) textColor: ColorWithHex(@"#ED8508") textAlignment:NSTextAlignmentRight];
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    [mStr appendAttributedString:str1];
    data.amount = mStr;
    cellModel.data = data;
    
    [sectionModel addCellModel:cellModel];
    
    //结算方式
    KKCellModel *cellModel4 = [KKCellModel new];
    cellModel4.cellClass = NSClassFromString(@"RemarkTableViewCell");
    RemarkTableViewCellModel *data4 = [RemarkTableViewCellModel new];
    data4.title = [CMLinkTextViewItem attributeStringWithText:@"结算方式" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
    
    data4.content = [CMLinkTextViewItem attributeStringWithText:purchase[@"payType"] textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
    cellModel4.data = data4;
    [sectionModel addCellModel:cellModel4];
    
    //发票
    KKCellModel *cellModel1 = [KKCellModel new];
    cellModel1.cellClass = NSClassFromString(@"RemarkTableViewCell");
    RemarkTableViewCellModel *data1 = [RemarkTableViewCellModel new];
    data1.title = [CMLinkTextViewItem attributeStringWithText:@"发票" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
    
    NSMutableString * invoices = [NSMutableString string];
    [invoices appendString:purchase[@"invoices"]];
    [invoices appendString:@"\n"];
    [invoices appendString:purchase[@"taxNo"]];
    
    data1.content = [CMLinkTextViewItem attributeStringWithText:invoices textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
    cellModel1.data = data1;
    [sectionModel addCellModel:cellModel1];

    return sectionModel;
}


@end
