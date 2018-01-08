//
//  MallOrderInfoModel.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MallOrderInfoModel.h"
#import "MallOrderReceiverInfoCell.h"
#import "MallOrderdetailMerchandiseCell.h"
#import "MallOrderGoodsHeader.h"
#import "MallOrderInvoiceCell.h"
#import "MallOrderPayCell.h"

typedef NS_ENUM(NSInteger, MallOrderInfoPayType) {
    MallOrderInfoPayTypeAli = 1,        // 支付宝
    MallOrderInfoPayTypeOffline         // 线下
};
NSString *const aliPayName = @"支付宝";
NSString *const offlinePayName = @"线下支付";
@interface MallOrderInfoModel ()

@property (nonatomic,strong) NSDictionary *orderInfoDic;
// 收货人姓名
@property (nonatomic,copy) NSString *receiverName;
// 收货人地址
@property (nonatomic,copy) NSString *receiverAddress;
// 收货人手机号
@property (nonatomic,copy) NSString *receiverMobile;
// 收货人地区id
@property (nonatomic,strong) NSNumber *receiverAreaId;
//// 收货人地区信息
//@property (nonatomic,copy) NSDictionary *receiverAreaInfo;
// 收货人地址id
@property (nonatomic,copy) NSString *addressId;
// 是否需要发票
@property (nonatomic,assign) BOOL needInvoice;
// 发票抬头
@property (nonatomic,copy) NSString *invoiceHeader;
// 税务号
@property (nonatomic,copy) NSString *invoiceTaxNo;
// 支付类型
@property (nonatomic,assign) MallOrderInfoPayType payType;

@property (nonatomic,assign) BOOL showShopping;
@end

@implementation MallOrderInfoModel

- (void)inputOrderInfoResponse:(NSDictionary *)responseObject showShopping:(BOOL)showShopping {
    self.orderInfoDic = responseObject;
    self.showShopping = showShopping;
    if (responseObject) {
        self.receiverName = responseObject[@"receiverInfo"][@"name"];
        NSString *address = responseObject[@"receiverInfo"][@"address"];
        if (!address) {
            NSMutableString *str = [NSMutableString string];
            NSDictionary *areaInfo = responseObject[@"receiverInfo"][@"areaInfo"];
            [str appendString:areaInfo[@"province"]];
            [str appendString:areaInfo[@"city"]];
            [str appendString:areaInfo[@"district"]];
            [str appendString:areaInfo[@"town"]];
            [str appendString:responseObject[@"receiverInfo"][@"village"]];
            address = str.copy;
        }
        self.receiverAddress = address;
        self.receiverMobile = responseObject[@"receiverInfo"][@"mobile"];
        self.receiverAreaId = responseObject[@"receiverInfo"][@"areaInfo"][@"areaId"];
        self.addressId = responseObject[@"receiverInfo"][@"addressId"];
    }
}
- (void)inputReceivePerson:(NSDictionary *)receive {
    if (receive) {
        self.receiverName = receive[@"name"];
        self.receiverAddress = receive[@"address"];
        self.receiverMobile = receive[@"mobile"];
        self.receiverAreaId = receive[@"areaId"];
//        self.receiverAreaInfo = receive[@"areaInfo"];
        self.addressId = receive[@"addressId"];
    }
}
- (void)setInvoiceOn:(BOOL)on {
    self.needInvoice = on;
}
- (void)setInvoiceInfoForRow:(NSInteger)row text:(NSString *)text {
    if (row == 0) {   // 抬头
        self.invoiceHeader = text;
    } else if (row == 1) {  // 税务号
        self.invoiceTaxNo = text;
    }
}
- (void)setPayTypeForRow:(NSInteger)row {
    if (row == 0) {
        self.payType = MallOrderInfoPayTypeAli;
    } else if (row == 1) {
        self.payType = MallOrderInfoPayTypeOffline;
    }
}
- (NSString *)tableFooterModel {
    NSNumber *totalPrice = self.orderInfoDic[@"totalAmount"];
    NSString *priceStr = [Calculate amountDisplayCalculateTwoFloat:totalPrice];
    NSString *result = @"¥0.00";
    if (priceStr) {
        result = [NSString stringWithFormat:@"¥%@",priceStr];
    }
    return result;
}
- (KKTableViewModel *)tableViewModel {
    KKTableViewModel *tableModel = [KKTableViewModel new];
    [tableModel addSetionModel:[self receiverInfoSectionModel]];
    [tableModel addSetionModel:[self goodsSectionModel]];
    [tableModel addSetionModel:[self invoiceSectionModel]];
    [tableModel addSetionModel:[self paySectionModel]];
    return tableModel;
}

/** 用户信息区*/
- (KKSectionModel *)receiverInfoSectionModel {
    KKSectionModel *section = [KKSectionModel new];
    section.footerData = [self tenHeightFooter];
    [section addCellModel:[self receiverInfoCellModel]];
    return section;
}
/** 商品列表区*/
- (KKSectionModel *)goodsSectionModel {
    KKSectionModel *section = [KKSectionModel new];
    section.headerData = [self goodsSectionHeaderModel];
    section.footerData = [self goodsSectionFooterModel];
    [section addCellModelList:[self goodsCellModelList]];
    return section;
}
/** 发票信息区*/
- (KKSectionModel *)invoiceSectionModel {
    KKSectionModel *section = [KKSectionModel new];
    section.footerData = [self tenHeightFooter];
    section.headerData = [self invoiceSectionHeaderModel];
    [section addCellModelList:[self invoiceCellModelList]];
    return section;
}
/** 支付信息区*/
- (KKSectionModel *)paySectionModel {
    KKSectionModel *section = [KKSectionModel new];
    section.headerData = [self paySectionHeaderModel];
    section.footerData = [self tenHeightFooter];
    [section addCellModelList:[self payCellModelList]];
    return section;
}
- (KKCellModel *)receiverInfoCellModel {
    MallOrderReceiverInfoCellModel *(^receiverInfoCellData)(void) = ^(void) {
        MallOrderReceiverInfoCellModel *data = [MallOrderReceiverInfoCellModel new];
        
        data.receiverName = [NSString stringWithFormat:@"收货人：%@",self.receiverName ? self.receiverName : @""];
        data.receiverMobile = self.receiverMobile;
//        NSString *areaStr = @"";
//        NSDictionary *areaInfo = self.receiverAreaInfo;
//        if (areaInfo) {
//            NSMutableString *mStr = @"".mutableCopy;
//            NSString *province = areaInfo[@"province"];
//            NSString *city = areaInfo[@"city"];
//            NSString *district = areaInfo[@"district"];
//            NSString *town = areaInfo[@"town"];
//            NSString *village = areaInfo[@"village"];
//            [self mString:mStr safeAppendString:province];
//            [self mString:mStr safeAppendString:city];
//            [self mString:mStr safeAppendString:district];
//            [self mString:mStr safeAppendString:town];
//            [self mString:mStr safeAppendString:village];
//            [self mString:mStr safeAppendString:self.receiverAddress];
//            areaStr = mStr.copy;
//        }
        data.receiverFullAddress = [NSString stringWithFormat:@"收货地址:%@",self.receiverAddress ? self.receiverAddress : @""];
        return data;
    };
    
    KKCellModel *cell = [KKCellModel new];
    cell.height = 110.0f;
    cell.cellClass = NSClassFromString(@"MallOrderReceiverInfoCell");
    cell.data = receiverInfoCellData();
    return cell;
}
- (KKCellModel *)goodsSectionHeaderModel {
    MallOrderGoodsHeaderModel *(^goodsHeaderData)(void) = ^(void) {
        MallOrderGoodsHeaderModel *data = [MallOrderGoodsHeaderModel new];
        data.headerTitle = @"产品信息";
        data.showShopping = self.showShopping;
        return data;
    };
    KKCellModel *cell = [KKCellModel new];
    cell.height = 50.0f;
    cell.cellClass = NSClassFromString(@"MallOrderGoodsHeader");
    cell.data = goodsHeaderData();
    return cell;
}
- (KKCellModel *)goodsSectionFooterModel {
    KKCellModel *cell = [KKCellModel new];
    cell.height = 60.0f;
    cell.cellClass = NSClassFromString(@"MallOrderGoodsFooter");
    NSString *price = [Calculate amountDisplayCalculateTwoFloat:self.orderInfoDic[@"totalAmount"]];
    cell.data = [NSString stringWithFormat:@"合计总金额：¥%@",price ? price :@"0.00"];
    return cell;
}
- (NSArray <KKCellModel *>*)goodsCellModelList {
    NSMutableArray *goodsCellList = @[].mutableCopy;
    NSArray *wholesaleList = self.orderInfoDic[@"wholesaleOrder"];
    for (NSDictionary *wholesale in wholesaleList) {
        NSArray *goodsList = wholesale[@"goodsList"];
        for (NSDictionary *goods in goodsList) {
            [goodsCellList addObject:[self goodsCellModelWithGoodsDic:goods]];
        }
    }
    return goodsCellList.copy;
}
- (KKCellModel *)goodsCellModelWithGoodsDic:(NSDictionary *)goods {
    MallOrderdetailMerchandiseCellModel *(^goodsCellData)(void) = ^(void) {
        MallOrderdetailMerchandiseCellModel *data = [MallOrderdetailMerchandiseCellModel new];
        data.imageUrl = goods[@"imgUrl"];
        data.title = goods[@"name"];
        data.spec = goods[@"spec"];
        NSString *price = [Calculate amountDisplayCalculateTwoFloat:goods[@"price"]];
        NSString *amount = [Calculate amountDisplayCalculateTwoFloat:goods[@"amount"]];
        data.price = [NSString stringWithFormat:@"单价¥%@",price ? price :@"0.00"];
        data.count = [NSString stringWithFormat:@"x%@",goods[@"count"]];
        NSString *total = [NSString stringWithFormat:@"应付款：¥%@",amount ? amount :@"0.00"];
        data.total = [[NSAttributedString alloc]initWithString:total attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSFontAttributeName:APPFONT(17)}];
        return data;
    };
    KKCellModel *cell = [KKCellModel new];
//    cell.height = 110.0f;
    cell.cellClass = NSClassFromString(@"MallOrderdetailMerchandiseCell");
    cell.data = goodsCellData();
    return cell;
}
- (KKCellModel *)invoiceSectionHeaderModel {
    KKCellModel *cell = [KKCellModel new];
    cell.height = 75.0f;
    cell.cellClass = NSClassFromString(@"MallOrderInvoiceHeader");
    cell.data = @(self.needInvoice);
    return cell;
}
- (NSArray <KKCellModel *>*)invoiceCellModelList {
    if (self.needInvoice) {
        NSMutableArray *invoiceCellList = @[].mutableCopy;
        [invoiceCellList addObject:[self invoiceCellModelWithLeftTitle:@"抬头" content:self.invoiceHeader placeholder:@"请输入发票抬头" keyboardType:UIKeyboardTypeDefault]];
        [invoiceCellList addObject:[self invoiceCellModelWithLeftTitle:@"税务号" content:self.invoiceTaxNo placeholder:@"请输入发票统一税务号" keyboardType:UIKeyboardTypeDefault]];
        return invoiceCellList.copy;
    }
    return @[];
}
- (KKCellModel *)invoiceCellModelWithLeftTitle:(NSString *)leftTitle content:(NSString *)content placeholder:(NSString *)placeholder keyboardType:(UIKeyboardType)keyboardType {
    MallOrderInvoiceCellModel *(^invoiceCellData)(void) = ^() {
        MallOrderInvoiceCellModel *data = [MallOrderInvoiceCellModel new];
        data.leftTitle = leftTitle;
        data.content = content;
        data.placeholder = placeholder;
        data.keyboardType = keyboardType;
        return data;
    };
    KKCellModel *cell = [KKCellModel new];
    cell.height = 50.0f;
    cell.cellClass = NSClassFromString(@"MallOrderInvoiceCell");
    cell.data = invoiceCellData();
    return cell;
}
- (KKCellModel *)paySectionHeaderModel {
    KKCellModel *cell = [KKCellModel new];
    cell.height = 35.0f;
    cell.cellClass = NSClassFromString(@"MallOrderPayHeader");
    cell.data = @"支付信息";
    return cell;
}
- (NSArray <KKCellModel *>*)payCellModelList {
    NSMutableArray *payCellList = @[].mutableCopy;
    [payCellList addObject:[self payCellModelWithPayIcon:@"alipay_icon" name:aliPayName description:@"供应商接单后支付" payType:MallOrderInfoPayTypeAli]];
    [payCellList addObject:[self payCellModelWithPayIcon:@"offlinepay_icon" name:offlinePayName description:nil payType:MallOrderInfoPayTypeOffline]];
    return payCellList.copy;
}
- (KKCellModel *)payCellModelWithPayIcon:(NSString *)payIcon name:(NSString *)payName description:(NSString *)description payType:(MallOrderInfoPayType)payType {
    UIImage *iconImage = [UIImage imageNamed:payIcon];
    NSAttributedString *payContent = [[NSAttributedString alloc]initWithString:payName attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSFontAttributeName:APPFONT(18)}];
    if (description) {
        NSMutableAttributedString *mAttribut = [[NSMutableAttributedString alloc]initWithAttributedString:payContent];
        [mAttribut appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",description] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:APPFONT(12)}]];
        payContent = mAttribut.copy;
    }
    UIImage *selectedImage = payType == self.payType ? [UIImage imageNamed:@"icon_orange_checkbox"] : [UIImage imageNamed:@"icon_grey_checkbox"];
    MallOrderPayCellModel *(^payCellData)(void) = ^() {
        MallOrderPayCellModel *data = [MallOrderPayCellModel new];
        data.payIcon = iconImage;
        data.content = payContent;
        data.selectedImage = selectedImage;
        return data;
    };
    KKCellModel *cell = [KKCellModel new];
    cell.height = 75.0f;
    cell.cellClass = NSClassFromString(@"MallOrderPayCell");
    cell.data = payCellData();
    return cell;
}
- (KKCellModel *)tenHeightFooter {
    KKCellModel *footer = [KKCellModel new];
    footer.height = 10.0f;
    return footer;
}
- (void)mString:(NSMutableString *)mString safeAppendString:(NSString *)aString {
    if (mString && aString) {
        [mString appendString:aString];
    }
}
- (NSString *)payNameForType:(MallOrderInfoPayType)payType {
    NSString *payName = nil;
    switch (payType) {
        case MallOrderInfoPayTypeAli:
            payName = aliPayName;
            break;
        case MallOrderInfoPayTypeOffline:
            payName = offlinePayName;
            break;
        default:
            break;
    }
    return payName;
}
#pragma mark - getter
- (NSString *)payName {
    return [self payNameForType:self.payType];
}
- (CGFloat)totalAmount {
    CGFloat total = 0.00;
    NSString *totalInfo = self.orderInfoDic[@"totalAmount"];
    if (totalInfo) {
        total = [totalInfo floatValue];
    }
    return total;
}
- (NSArray *)wholesaleOrder {
    return self.orderInfoDic[@"wholesaleOrder"];
}

@end
