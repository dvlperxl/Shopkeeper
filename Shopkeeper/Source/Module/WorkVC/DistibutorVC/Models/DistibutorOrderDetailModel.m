//
//  DistibutorOrderDetailModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "DistibutorOrderDetailModel.h"

#import "DistibutorOrderDetailAddressCell.h"
#import "OrderListTableHeaderView.h"
#import "MallOrderdetailMerchandiseCell.h"
#import "GoodsCountTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "StockOrderDetailHeaderView.h"




@implementation DistibutorOrderDetailInfo

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"listOrderGoodsInfoDto":@"DistibutorOrderDetailGoodsInfo"};
}


- (StockOrderDetailHeaderViewModel*)headerViewModel
{
    StockOrderDetailHeaderViewModel*model = [StockOrderDetailHeaderViewModel new];
    
    model.title = self.wholesaleName;
    model.mobile = self.wholesalePhone;
    model.orderTime = self.orderTime;
    model.orderNo = self.orderNo;
    NSString *status = self.orderState;
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



- (KKSectionModel*)addressSection
{
    KKSectionModel*section = [KKSectionModel new];
    section.footerData.height = 10;
    
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.cellClass = NSClassFromString(@"DistibutorOrderDetailAddressCell");
    DistibutorOrderDetailAddressCellModel *data = [DistibutorOrderDetailAddressCellModel new];
    data.name = self.consignee;
    data.mobile = self.consigneePhone;
    data.imageName = @"icon_recipient";
    if (self.deliverMethod == 2) {
        data.address = self.address;
        data.hideLine = YES;
    }
    cellModel.data = data;
    [section addCellModel:cellModel];
    
    if (self.deliverMethod == 2) {
        
        KKCellModel *cellModel1 = [KKCellModel new];
        cellModel1.cellClass = NSClassFromString(@"DistibutorOrderDetailAddressCell");
        DistibutorOrderDetailAddressCellModel *data1 = [DistibutorOrderDetailAddressCellModel new];
        data1.name = self.storeName;
        data1.mobile = self.storePhone;
        data1.imageName = @"icon_selfpickup";
        data1.hideLine = YES;
        cellModel1.data = data1;
        [section addCellModel:cellModel1];
    }
    
    return section;
}

-(KKSectionModel*)goodsSectionModel
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    sectionModel.footerData.height = 10;
    sectionModel.headerData.height = 50;
    sectionModel.headerData.cellClass = NSClassFromString(@"OrderListTableHeaderView");
    OrderListTableHeaderViewModel *data = [OrderListTableHeaderViewModel new];
    data.title = @"产品信息";
    data.hideLine = NO;
    sectionModel.headerData.data = data;
    for (DistibutorOrderDetailGoodsInfo * goodsInfo in self.listOrderGoodsInfoDto)
    {
        [sectionModel addCellModel:[self goodsCellModel:goodsInfo]];
    }
    [sectionModel addCellModel:[self totalAmountCellModel]];
    return sectionModel;
}

- (KKCellModel*)totalAmountCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 50;
    cellModel.cellType = @"goodsCount";
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = [NSString stringWithFormat:@"共%@件商品",@(self.listOrderGoodsInfoDto.count)];
    NSString *totalAmount = AMOUNTSTRING(@(self.totalAmount));
    NSString *total = STRING(@"合计：¥",totalAmount);
    data.amount = [CMLinkTextViewItem attributeStringWithText:total textFont:APPFONT(17) textColor: ColorWithHex(@"#333333") textAlignment:NSTextAlignmentRight];
    cellModel.data = data;
    return cellModel;
}

- (KKCellModel*)goodsCellModel:(DistibutorOrderDetailGoodsInfo*)goodsInfo
{
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"MallOrderdetailMerchandiseCell");
    MallOrderdetailMerchandiseCellModel *data = [MallOrderdetailMerchandiseCellModel new];
    data.imageUrl = goodsInfo.imageUrl;
    data.title = goodsInfo.title;
    data.spec = goodsInfo.spec;
    data.price = [NSString stringWithFormat:@"单价¥%@",AMOUNTSTRING(goodsInfo.salePrice)];
    data.count = STRING(@"x", goodsInfo.goodsNum);
    double yfAmout = goodsInfo.salePrice.doubleValue *  goodsInfo.goodsNum.integerValue;
    self.totalAmount+=yfAmout;
    NSString *yfStr = AMOUNTSTRING(@(yfAmout));
    
    NSAttributedString *item1 = [CMLinkTextViewItem attributeStringWithText:@"应付款：¥" textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")];
    NSAttributedString *item2 = [CMLinkTextViewItem attributeStringWithText:yfStr textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]init];
    [aStr appendAttributedString:item1];
    [aStr appendAttributedString:item2];
    data.total = aStr;
    
    return cell;
}

- (KKSectionModel*)finalAmountSectionModel
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellClass = NSClassFromString(@"GoodsCountTableViewCell");
    GoodsCountTableViewCellModel *data = [GoodsCountTableViewCellModel new];
    data.title = @"订单总金额";
    NSString *totalAmount = self.orderAmt;
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
    
    data4.content = [CMLinkTextViewItem attributeStringWithText:self.paymentType textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
    cellModel4.data = data4;
    [sectionModel addCellModel:cellModel4];
    
//    //发票
//    KKCellModel *cellModel1 = [KKCellModel new];
//    cellModel1.cellClass = NSClassFromString(@"RemarkTableViewCell");
//    RemarkTableViewCellModel *data1 = [RemarkTableViewCellModel new];
//    data1.title = [CMLinkTextViewItem attributeStringWithText:@"发票" textFont:APPFONT(17) textColor:ColorWithHex(@"#999999")];
//
//    NSMutableString * invoices = [NSMutableString string];
//    [invoices appendString:purchase[@"invoices"]];
//    [invoices appendString:@"\n"];
//    [invoices appendString:purchase[@"taxNo"]];
//
//    data1.content = [CMLinkTextViewItem attributeStringWithText:invoices textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")textAlignment:NSTextAlignmentRight];
//    cellModel1.data = data1;
//    [sectionModel addCellModel:cellModel1];
    
    
    
    return sectionModel;
}

@end


@implementation DistibutorOrderDetailGoodsInfo


- (NSString *)title
{
    if (!_title) {
        
        NSMutableString *title = [NSMutableString string];
        NSString *goodsBrand = [NSString stringWithFormat:@"[%@]",self.goodsBrand];
        [title appendString:goodsBrand];
        [title appendString:@"  "];
        [title appendString:self.goodsName];
        [title appendString:@"  "];
        [title appendString:self.content];
        [title appendString:self.contentUnit];
        
        _title = title.copy;
    }
    return _title;
}

- (NSString *)spec
{
    if (!_spec) {
        
        NSMutableString *spec = [NSMutableString string];
        [spec appendString:self.speciNum];
        [spec appendString:self.speciUnit1];
        [spec appendString:@"*"];
        [spec appendString:self.wrapNum];
        [spec appendString:self.speciUnit2];
        [spec appendString:@"/"];
        [spec appendString:self.wrapUnit];
        
        _spec = spec.copy;
    }
    return _spec;
}

@end

@implementation DistibutorOrderDetailModel

+ (KKTableViewModel*)orderDetailTableViewModel:(NSDictionary*)orderDetail
{
    DistibutorOrderDetailInfo *detailInfo = [DistibutorOrderDetailInfo modelObjectWithDictionary:orderDetail];
    
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.headerViewModel = [detailInfo headerViewModel];
    [tableViewModel addSetionModel:[detailInfo addressSection]];
    [tableViewModel addSetionModel:[detailInfo goodsSectionModel]];
    [tableViewModel addSetionModel:[detailInfo finalAmountSectionModel]];
    return tableViewModel;
}



@end

