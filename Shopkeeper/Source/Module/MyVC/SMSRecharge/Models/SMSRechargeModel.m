//
//  SMSRechargeModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "SMSRechargeModel.h"
#import "SMSRechargeCell.h"
#import "SMSTableViewCell.h"
#import "MallOrderPayCell.h"

@implementation SMSRechargeModel

+ (KKTableViewModel *)tableViewModel:(NSDictionary*)dict
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    
    KKSectionModel *sectionModel1 = [KKSectionModel new];
    sectionModel1.footerData.height = 10;
    [tableViewModel addSetionModel:sectionModel1];

    KKCellModel *cellModel1 = [KKCellModel new];
    cellModel1.cellClass = NSClassFromString(@"SMSRechargeCell");
    cellModel1.height = 100;
    cellModel1.data =  STRINGWITHOBJECT(dict[@"storeSmsNumber"]);
    [sectionModel1 addCellModel:cellModel1];
    
    
    KKSectionModel *sectionModel2 = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel2];
    KKCellModel *cellModel2 = [KKCellModel new];
    cellModel2.cellClass = NSClassFromString(@"SMSTableViewCell");
    cellModel2.height = 150;
    cellModel2.data =  dict[@"smsconfig"];
    [sectionModel2 addCellModel:cellModel2];
    
    
    KKSectionModel *sectionModel3 = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel3];
    KKCellModel *cellModel3 = [KKCellModel new];
    cellModel3.cellClass = NSClassFromString(@"MallOrderPayCell");
    cellModel3.cellType = @"MallOrderPayCell";
    cellModel3.height = 75;
    MallOrderPayCellModel *data = [MallOrderPayCellModel new];
    data.selectedImage = [UIImage imageNamed:@"icon_orange_checkbox"];
    data.payIcon = Image(@"alipay_icon");
    data.content = [CMLinkTextViewItem attributeStringWithText:@"支付宝" textFont:APPFONT(18) textColor:ColorWithHex(@"#333333")];
    cellModel3.data = data;
    [sectionModel3 addCellModel:cellModel3];

//    UIImage *selectedImage = payType == self.payType ? [UIImage imageNamed:@"icon_orange_checkbox"] : [UIImage imageNamed:@"icon_grey_checkbox"];
    
    return tableViewModel;
}

@end
