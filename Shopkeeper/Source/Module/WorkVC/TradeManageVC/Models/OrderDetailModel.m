//
//  OrderDetailModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailModel.h"
#import "OrderStatusTableViewCell.h"
#import "OrderDetailAddressTableViewCell.h"
#import "OrderDetailMerchandiseCell.h"
#import "OrderDatailTableViewCell.h"
#import "OrderDetailMerchandiseCell2.h"
#import "OrderDetailQueryOrderCell.h"

@interface OrderDetailModel()

@property(nonatomic,copy)NSDictionary *orderDetail;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,strong)NSDictionary *retail;
@property(nonatomic,assign)NSInteger retailCount;

@end

@implementation OrderDetailModel

-(NSDictionary *)retail
{
    if (!_retail) {
        
        _retail = self.orderDetail[@"retail"];
        if (self.status.integerValue == 9)
        {
            _retail = self.orderDetail[@"storeRetail"];
        }
    }
    return _retail;
}

- (BOOL)showBottomView
{
    if (self.status.integerValue == 1||self.status.integerValue == 2)
    {
        return YES;
    }
    
    // C_APP
    if (self.status.integerValue == 3)
    {
        
        //B端
        NSString *datafrom = self.retail[@"datafrom"];
        if ([datafrom isEqualToString:@"B_APP"])
        {
            if (self.reStatus!=1) {
                
                return YES;
            }
        }
        
        //C端
        
        if ([datafrom isEqualToString:@"C_APP"])
        {
            if (self.reStatus==3)
            {
                return YES;
            }
        }
        
    }
    return NO;
}

+ (instancetype)orderDetailModel:(NSDictionary*)orderDetail orderStatus:(NSString*)status
{
    OrderDetailModel *model = [OrderDetailModel new];
    model.orderDetail = orderDetail;
    model.status = status;
    model.reStatus = [orderDetail[@"retail"][@"reStatus"] integerValue];
    return model;
}

- (KKTableViewModel *)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    
    [tableViewModel addSetionModel:[self addressSection]];
    [tableViewModel addSetionModel:[self orderSection]];
    
    NSArray *details = self.orderDetail[@"details"];
    self.retailCount = 0;
    for (NSDictionary *detail in details)
    {
        [tableViewModel addSetionModel:[self detailSection:detail]];
    }
    
    NSArray *prescriptionRetailDetails = self.orderDetail[@"prescriptionRetailDetail"];
    if (self.status.integerValue == 9)
    {
        prescriptionRetailDetails = self.orderDetail[@"prescriptionReturn"];
    }
    
    for (NSDictionary *prescriptionRetailDetail in prescriptionRetailDetails)
    {
        [tableViewModel addSetionModel:[self prescriptionRetailDetail:prescriptionRetailDetail]];
    }
    
    [tableViewModel addSetionModel:[self totalIdSection]];
    [tableViewModel addSetionModel:[self amoutSection]];
    [tableViewModel addSetionModel:[self modeSection]];
    if (self.status.integerValue == 9) {
        [tableViewModel addSetionModel:[self queryOrderSection]];
    }

    return tableViewModel;
}

- (KKSectionModel *)addressSection
{
    KKSectionModel *section = [KKSectionModel new];
    
    //insertTime
    KKCellModel *cellModel1 = [[KKCellModel alloc]init];
    cellModel1.cellClass =  NSClassFromString(@"OrderStatusTableViewCell");
    cellModel1.height = 80;
    OrderStatusTableViewCellModel *data1 = [OrderStatusTableViewCellModel new];
    cellModel1.data = data1;
    data1.orderStatus = [self orderStatusString];
    
    NSDictionary *retail = self.orderDetail[@"retail"];
    if (self.status.integerValue == 9)
    {
        retail = self.orderDetail[@"storeRetail"];
    }
    
    data1.orderTime = [NSString stringWithFormat:@"下单时间：%@",retail[@"insertTime"]];

    [section addCellModel:cellModel1];
    // address
    
    KKCellModel *cellModel2 = [[KKCellModel alloc]init];
    cellModel2.cellClass =  NSClassFromString(@"OrderDetailAddressTableViewCell");
    
    OrderDetailAddressTableViewCellModel *data2 = [OrderDetailAddressTableViewCellModel new];
    cellModel2.data = data2;
    
    data2.name = STRING(@"收货人:",self.orderDetail[@"customer"][@"customerNme"]);
    data2.mobile = self.orderDetail[@"customer"][@"customerPhone"];
    data2.address = retail[@"deliverAddress"];

    cellModel2.height = [data2.address calculateHeight:CGSizeMake(SCREEN_WIDTH-73, 200) font:APPFONT(15)]+68;
    
    [section addCellModel:cellModel2];

    return section;
}


- (KKSectionModel *)orderSection
{
    
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 10;
    //
    KKCellModel *orderIdCell = [KKCellModel new];
    orderIdCell.height = 50;
    orderIdCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
    
    OrderDatailTableViewCellModel *orderIdData = [OrderDatailTableViewCellModel new];
    orderIdCell.data = orderIdData;
    orderIdData.title = [CMLinkTextViewItem attributeStringWithText:@"订单信息" textFont:APPFONT(17) textColor:ColorWithRGB(51, 51, 51, 1)];
    
    NSString *retailNo = self.retail[@"retailNo"];
    if (self.status.integerValue == 9) {
        
        retailNo = self.orderDetail[@"storeReturn"][@"returnNo"];
    }
    retailNo = STRING(@"订单号", retailNo);
    orderIdData.content = [CMLinkTextViewItem attributeStringWithText:retailNo textFont:APPFONT(15) textColor:ColorWithRGB(153, 153, 153, 1) textAlignment:NSTextAlignmentRight];
    [section addCellModel:orderIdCell];
    //
    
    return section;
}

- (KKSectionModel*)detailSection:(NSDictionary*)detail
{
    KKSectionModel *section = [KKSectionModel new];
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"OrderDetailMerchandiseCell");
    OrderDetailMerchandiseCellModel *data = [OrderDetailMerchandiseCellModel new];
    data.name = detail[@"goodsName"];
    data.brand = detail[@"goodsBrand"];
    cell.height = [data.name calculateHeight:CGSizeMake(SCREEN_WIDTH-120, 200) font:APPFONT(17)]+55;
    
    
    NSString *amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(detail[@"retailPrice"])];
    NSNumber *num = detail[@"retailNum"];
    
    if (self.status.integerValue == 9)
    {
        
        amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(detail[@"returnPrice"])];
        num = detail[@"returnNum"];
    }
    
    data.amount = amount;
    data.desc = detail[@"goodsSpeci"];
    data.count = STRING(@"x", num);
    cell.data = data;
    self.retailCount += [num integerValue];
    [section addCellModel:cell];
    return section;
}

- (KKSectionModel *)prescriptionRetailDetail:(NSDictionary*)detail
{
    KKSectionModel *section = [KKSectionModel new];
    
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"OrderDetailMerchandiseCell");
    OrderDetailMerchandiseCellModel *data = [OrderDetailMerchandiseCellModel new];
    
    data.name = detail[@"prescriptionName"];
    data.brand = STRING(detail[@"prescriptionSpecName"], @"/套");
    
    cell.height = [data.name calculateHeight:CGSizeMake(SCREEN_WIDTH-120, 200) font:APPFONT(17)]+55;
    NSString *amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(detail[@"prescriptionPrice"])];
    
    data.amount = amount;
    
    NSNumber *number = detail[@"actNumber"];
    if (self.status.integerValue == 9) {
        number = detail[@"number"];
    }
    data.count = STRING(@"x", number);

    data.hideLine = YES;
    cell.data = data;
    self.retailCount += [number integerValue];
    [section addCellModel:cell];
    
    BOOL open = NO;
    
    NSString *prescriptionRetailId = detail[@"prescriptionRetailId"];
    if (self.status.integerValue == 9) {
        prescriptionRetailId = detail[@"prescriptionId"];
    }
    
    
    if (self.selectRetailId && [self.selectRetailId isEqualToString:prescriptionRetailId])
    {
        open = YES;
    }
    
    NSLog(@"open:%@",@(open));
    
    [section addCellModel:[self preDetailCell:detail[@"detail"] open:open retailId:prescriptionRetailId]];

    return section;
}

- (KKCellModel *)preDetailCell:(NSArray *)details open:(BOOL)open retailId:(NSString*)retailId
{
    if (details.count==0) {
        return nil;
    }
    KKCellModel *cell = [KKCellModel new];
    cell.cellClass = NSClassFromString(@"OrderDetailMerchandiseCell2");
    cell.height = 50;
    
    OrderDetailMerchandiseCell2Model *model = [OrderDetailMerchandiseCell2Model new];
    model.open = open;
    model.retailId = retailId;
    
    CGFloat height = 56;
    
    
    NSMutableArray *list = @[].mutableCopy;
    for (NSInteger i = 0; i<details.count; i++)
    {
        NSDictionary *detail = details[i];
        OrderDetailMerchandiseSubviewModel *data = [OrderDetailMerchandiseSubviewModel new];
        NSString *title = [NSString stringWithFormat:@"%@ %@",detail[@"goodsBrand"],detail[@"goodsName"]];
        data.title = title;
        data.content = detail[@"goodsSpeci"];
        data.height = [title calculateHeight:CGSizeMake(SCREEN_WIDTH-145, 40) font:APPFONT(15)]+1;
        [list addObject:data];
        
        height += data.height;
        height += 13;
    }
    
    if (model.open) {
        cell.height = height+10;
    }
    model.preList = list.copy;
    cell.data = model;
    
    return cell;
}

- (KKSectionModel*)totalIdSection
{
    KKSectionModel *section = [KKSectionModel new];
    
    KKCellModel *totalIdCell = [KKCellModel new];
    totalIdCell.height = 50;
    totalIdCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
    
    OrderDatailTableViewCellModel *totalData = [OrderDatailTableViewCellModel new];
    totalIdCell.data = totalData;
    NSString *title = [NSString stringWithFormat:@"共%@件商品",@(self.retailCount)];
    totalData.title = [CMLinkTextViewItem attributeStringWithText:title textFont:APPFONT(17) textColor:ColorWithHex(@"#333333")];
    NSString *content = [NSString stringWithFormat:@"合计:¥%@",AMOUNTSTRING(self.retail[@"retailAmount"])];
    totalData.content = [CMLinkTextViewItem attributeStringWithText:content textFont:APPBOLDFONT(17) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    [section addCellModel:totalIdCell];
    
    return section;
}


- (KKSectionModel *)amoutSection
{
    
    NSDictionary *retail = self.orderDetail[@"retail"];
    if (self.status.integerValue == 9)
    {
        retail = self.orderDetail[@"storeRetail"];
    }
    
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 10;
    //discontAmount
    
    

    //coupon
    if (self.status.integerValue != 9) {
        
        
        KKCellModel *discontAmountCell = [KKCellModel new];
        [section addCellModel:discontAmountCell];
        discontAmountCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
        discontAmountCell.height = 50;
        OrderDatailTableViewCellModel *discontAmountData = [OrderDatailTableViewCellModel new];
        discontAmountCell.data = discontAmountData;
        discontAmountData.title = [CMLinkTextViewItem attributeStringWithText:@"优惠金额" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
        
        NSString *content = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(retail[@"discontAmount"])];
        discontAmountData.content = [CMLinkTextViewItem attributeStringWithText:content textFont:APPFONT(17) textColor:ColorWithRGB(244, 153, 0, 1) textAlignment:NSTextAlignmentRight];

        
        
        KKCellModel *couponCell = [KKCellModel new];
        [section addCellModel:couponCell];
        couponCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
        couponCell.height = 50;
        OrderDatailTableViewCellModel *couponData = [OrderDatailTableViewCellModel new];
        couponCell.data = couponData;
        couponData.title = [CMLinkTextViewItem attributeStringWithText:@"优惠劵减免" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
        
        NSString *couponContent = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(retail[@"coupon"])];
        couponData.content = [CMLinkTextViewItem attributeStringWithText:couponContent textFont:APPFONT(17) textColor:ColorWithRGB(244, 153, 0, 1) textAlignment:NSTextAlignmentRight];
    }
    
    //shareProfit
    
    if (retail[@"shareProfit"])
    {
        
        KKCellModel *shareProfitCell = [KKCellModel new];
        [section addCellModel:shareProfitCell];
        shareProfitCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
        shareProfitCell.height = 50;
        OrderDatailTableViewCellModel *shareProfitData = [OrderDatailTableViewCellModel new];
        shareProfitCell.data = shareProfitData;
        shareProfitData.title = [CMLinkTextViewItem attributeStringWithText:@"返利金额" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
        NSString *finalAmountContent = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(retail[@"shareProfit"])];
        shareProfitData.content = [CMLinkTextViewItem attributeStringWithText:finalAmountContent textFont:APPFONT(17) textColor:ColorWithRGB(108, 183, 59, 1) textAlignment:NSTextAlignmentRight];
        
    }
    
    //finalAmount
    
    KKCellModel *finalAmountCell = [KKCellModel new];
    [section addCellModel:finalAmountCell];
    finalAmountCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
    finalAmountCell.height = 50;
    OrderDatailTableViewCellModel *finalAmountData = [OrderDatailTableViewCellModel new];
    finalAmountCell.data = finalAmountData;
    finalAmountData.title = [CMLinkTextViewItem attributeStringWithText:@"结算金额" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
    NSString *finalAmountContent = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(retail[@"finalAmount"])];
    finalAmountData.content = [CMLinkTextViewItem attributeStringWithText:finalAmountContent textFont:APPFONT(17) textColor:ColorWithRGB(244, 153, 0, 1) textAlignment:NSTextAlignmentRight];
    
    return section;
}

- (KKSectionModel *)modeSection
{
    
    NSDictionary *retail = self.orderDetail[@"retail"];
    if (self.status.integerValue == 9)
    {
        retail = self.orderDetail[@"storeRetail"];
    }
    
    
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 10;

    //    deliver 0否  1 是

    KKCellModel *deliverCell = [KKCellModel new];
    [section addCellModel:deliverCell];
    deliverCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
    deliverCell.height = 50;
    
    OrderDatailTableViewCellModel *deliverData = [OrderDatailTableViewCellModel new];
    deliverCell.data = deliverData;
    deliverData.title = [CMLinkTextViewItem attributeStringWithText:@"是否送货" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
    NSString *deliver = @"否";
    if ([retail[@"deliver"] boolValue])
    {
        deliver = @"是";
    }
    deliverData.content =  [CMLinkTextViewItem attributeStringWithText:deliver textFont:APPFONT(17) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    

    //method
    
    KKCellModel *methodCell = [KKCellModel new];
    [section addCellModel:methodCell];
    methodCell.cellClass = NSClassFromString(@"OrderDatailTableViewCell");
    methodCell.height = 50;
    
    OrderDatailTableViewCellModel *methodData = [OrderDatailTableViewCellModel new];
    methodCell.data = methodData;
    methodData.title = [CMLinkTextViewItem attributeStringWithText:@"支付方式" textFont:APPFONT(17) textColor:ColorWithRGB(153, 153, 153, 1)];
    methodData.content =  [CMLinkTextViewItem attributeStringWithText:retail[@"method"] textFont:APPFONT(17) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    
    return section;
}

- (KKSectionModel*)queryOrderSection
{
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 10;
    
    KKCellModel *methodCell = [KKCellModel new];
    [section addCellModel:methodCell];
    methodCell.cellClass = NSClassFromString(@"OrderDetailQueryOrderCell");
    methodCell.height = 75;
    
    NSString *storeRetail = self.orderDetail[@"storeReturn"][@"storeRetail"];
    RouterModel *model = [RouterModel new];
    model.className = @"OrderDetailViewController";
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:storeRetail forKey:@"orderId"];
    [param setObject:@"3" forKey:@"status"];
    model.param = param.copy;
    methodCell.routerModel = model;
    
    return section;
}

- (NSString*)orderStatusString
{
    NSDictionary *orderStatus = @{
                                  @"1":@"待确认",
                                  @"2":@"待送货",
                                  @"3":@"已收货",
                                  @"7":@"待支付",
                                  @"9":@"已退货"
                                  };
    return orderStatus[self.status];
}


@end
