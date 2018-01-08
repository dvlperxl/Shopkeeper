//
//  DailyCheckModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "DailyCheckModel.h"
#import "DailyCheckListTableViewCell.h"
#import "NSDate+DateFormatter.h"

@implementation DailyCheckModel

- (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 50;
    section.headerData.cellClass = NSClassFromString(@"DailyCheckHeaderView");
    
    NSDate *date;
    NSString *dateString;
    
    if (self.dateString)
    {
        date = [NSDate dateWithDateString:self.dateString dateFormatter:YYYY_MM_dd];
    }
    if (date)
    {
        dateString = [date stringWithDateFormatter:TODAY_YYYY_M_D];
        
        if ([dateString isEqualToString:[[NSDate date]stringWithDateFormatter:TODAY_YYYY_M_D]])
        {
            dateString = STRING(@"今天 ",dateString);
        }
        
    }else
    {
        dateString = STRING(@"今天 ", [[NSDate date]stringWithDateFormatter:TODAY_YYYY_M_D]);

    }
    section.headerData.data = dateString;
    [tableViewModel addSetionModel:section];
    [section addCellModel:[self customerCellModel]];
    [section addCellModel:[self salesCellModel]];
    [section addCellModel:[self creditCellModel]];
    [section addCellModel:[self deliveryCellModel]];
    [section addCellModel:[self preapyCellModel]];
    [section addCellModel:[self returnCellModel]];
    
    return tableViewModel;
}

- (KKCellModel*)customerCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"work_home_menu_1";
    data.type = @"会员";
    data.title1 = @"新增会员数";
    data.title2 = @"新增VIP数";
    
    NSString *todaynumer = STRINGWITHOBJECT(self.customerCounts[@"todaynumer"]);
    data.content1 = [CMLinkTextViewItem attributeStringWithText:todaynumer textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *todayAddVipNumer = STRINGWITHOBJECT(self.customerCounts[@"todayAddVipNumer"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:todayAddVipNumer textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    return cellModel;
}

- (KKCellModel*)salesCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"ico_trade";
    data.type = @"销售";
    data.title1 = @"销售额";
    data.title2 = @"完成订单(笔)";
    
    NSString *totalAmount = @"¥0.00";
    if (self.saleInfos[@"totalAmount"] != nil) {
        
         totalAmount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.saleInfos[@"totalAmount"])];
        
    }
    
    
    data.content1 = [CMLinkTextViewItem attributeStringWithText:totalAmount textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *saleCount = STRINGWITHOBJECT(self.saleInfos[@"saleCount"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:saleCount textFont:APPFONT(18) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    
    return cellModel;
}

- (KKCellModel*)creditCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"ico_credit";
    data.type = @"赊销";
    data.title1 = @"赊销";
    data.title2 = @"赊销订单(笔)";
    
    NSString *credit_amount_num = @"¥0.00";
    if (self.saleInfos[@"credit_amount_num"] != nil) {
        
        
        credit_amount_num = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.saleInfos[@"credit_amount_num"])];
    }
    
    data.content1 = [CMLinkTextViewItem attributeStringWithText:credit_amount_num textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *creditCount = STRINGWITHOBJECT(self.saleInfos[@"creditCount"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:creditCount textFont:APPFONT(18) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    
    
    return cellModel;
}

- (KKCellModel*)deliveryCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"ico_truck";
    data.type = @"送货";
    data.title1 = @"未送货(笔)";
    data.title2 = @"已送货(笔)";
    
    NSString *unDeliveryCount = STRINGWITHOBJECT(self.delivery[@"unDeliveryCount"]);
    data.content1 = [CMLinkTextViewItem attributeStringWithText:unDeliveryCount textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *deliveryCount = STRINGWITHOBJECT(self.delivery[@"deliveryCount"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:deliveryCount textFont:APPFONT(18) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    
    return cellModel;
}

- (KKCellModel*)preapyCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"ico_wallet";
    data.type = @"预存款";
    data.title1 = @"充值额";
    data.title2 = @"充值(笔)";
    
    
    NSString *prepayAmount = @"¥0.00";
    if (self.preapy[@"prepayAmount"] != nil) {
        
        prepayAmount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.preapy[@"prepayAmount"])];
    }
    
    
    
    data.content1 = [CMLinkTextViewItem attributeStringWithText:prepayAmount textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *preapyCount = STRINGWITHOBJECT(self.preapy[@"preapyCount"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:preapyCount textFont:APPFONT(18) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    return cellModel;
}

- (KKCellModel*)returnCellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    
    cellModel.height = 90;
    cellModel.cellClass = NSClassFromString(@"DailyCheckListTableViewCell");
    
    DailyCheckListTableViewCellModel *data = [DailyCheckListTableViewCellModel new];
    cellModel.data = data;
    data.iconName = @"ico_repayment";
    data.type = @"还款";
    data.title1 = @"还款额";
    data.title2 = @"还款(笔)";
    
    NSString *prepayAmount = @"¥0.00";
    if (self.repayment[@"repaymentAmount"] != nil) {
        
        prepayAmount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.repayment[@"repaymentAmount"])];
    }
    
    data.content1 = [CMLinkTextViewItem attributeStringWithText:prepayAmount textFont:APPFONT(18) textColor:ColorWithRGB(242, 151, 0, 1) textAlignment:NSTextAlignmentRight];
    
    NSString *preapyCount = STRINGWITHOBJECT(self.repayment[@"repaymentCount"]);
    data.content2 = [CMLinkTextViewItem attributeStringWithText:preapyCount textFont:APPFONT(18) textColor:ColorWithRGB(51, 51, 51, 1) textAlignment:NSTextAlignmentRight];
    
    return cellModel;
}


@end
