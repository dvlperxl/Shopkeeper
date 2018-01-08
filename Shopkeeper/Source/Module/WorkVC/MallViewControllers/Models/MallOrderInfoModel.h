//
//  MallOrderInfoModel.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallOrderInfoModel : NSObject

// 收货人姓名
@property (nonatomic,copy,readonly) NSString *receiverName;
// 收货人地址
@property (nonatomic,copy,readonly) NSString *receiverAddress;
// 收货人手机号
@property (nonatomic,copy,readonly) NSString *receiverMobile;
// 收货人地区id
@property (nonatomic,strong,readonly) NSNumber *receiverAreaId;

// 支付类型名
@property (nonatomic,copy,readonly) NSString *payName;
// 支付价格
@property (nonatomic,assign,readonly) CGFloat totalAmount;
// 是否需要发票
@property (nonatomic,assign,readonly) BOOL needInvoice;
// 发票抬头
@property (nonatomic,copy,readonly) NSString *invoiceHeader;
// 税务号
@property (nonatomic,copy,readonly) NSString *invoiceTaxNo;
// 商品列表
@property (nonatomic,copy,readonly) NSArray *wholesaleOrder;
// 收货人地址id
@property (nonatomic,copy,readonly) NSString *addressId;


- (void)inputOrderInfoResponse:(NSDictionary *)responseObject showShopping:(BOOL)showShopping;
- (void)inputReceivePerson:(NSDictionary *)receive;

- (KKTableViewModel *)tableViewModel;
- (NSString *)tableFooterModel;

- (void)setInvoiceOn:(BOOL)on;
- (void)setInvoiceInfoForRow:(NSInteger)row text:(NSString *)text;
- (void)setPayTypeForRow:(NSInteger)row;
@end
