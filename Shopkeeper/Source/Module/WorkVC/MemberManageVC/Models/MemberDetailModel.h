//
//  MemberDetailModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberDetailModel : NSObject

@property(nonatomic,strong)NSDictionary *customer;


@property(nonatomic,strong)NSArray *crops;

@property(nonatomic,strong)NSNumber     *creditAmount;//赊欠额
@property(nonatomic,strong)NSNumber *retailCount;//消费次数


- (KKTableViewModel*)tableViewModel;

@end
