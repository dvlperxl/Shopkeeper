//
//  DistibutorOrderDetailModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/4.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistibutorOrderDetailModel : NSObject

+ (KKTableViewModel*)orderDetailTableViewModel:(NSDictionary*)orderDetail;

@end


@class DistibutorOrderDetailGoodsInfo;

@interface DistibutorOrderDetailInfo : NSObject<YYModel>

@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *consignee;
@property(nonatomic,strong)NSString *consigneePhone;

@property(nonatomic,assign)NSInteger deliverMethod;
@property(nonatomic,strong)NSNumber *goodsNum;
@property(nonatomic,strong)NSArray<DistibutorOrderDetailGoodsInfo*> *listOrderGoodsInfoDto;
@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *orderAmt;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *orderState;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *storePhone;
@property(nonatomic,strong)NSString *wholesaleName;
@property(nonatomic,strong)NSString *wholesalePhone;

@property(nonatomic,assign)CGFloat totalAmount;

@end

@interface DistibutorOrderDetailGoodsInfo : NSObject

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *contentUnit;
@property(nonatomic,copy)NSString *goodsBrand;
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,strong)NSNumber *goodsNum;
@property(nonatomic,copy)NSString *imageUrl;

@property(nonatomic,strong)NSNumber *salePrice;
@property(nonatomic,strong)NSNumber *salePriceForc;
@property(nonatomic,strong)NSString *speciNum;
@property(nonatomic,copy)NSString *speciUnit1;
@property(nonatomic,copy)NSString *speciUnit2;

@property(nonatomic,copy)NSString *wrapNum;
@property(nonatomic,copy)NSString *wrapUnit;

//

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *spec;


@end
