//
//  MemberModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject<YYModel>

@property(nonatomic,copy)NSString *customerNme;
@property(nonatomic,strong)NSNumber *amount;
@property(nonatomic,strong)NSNumber *creditAmount;
@property(nonatomic,copy)NSString *integration;
@property(nonatomic,strong)NSNumber *customerId;


+ (NSArray<KKCellModel*>*)cellModelList:(NSArray<MemberModel*>*)memberModelList;

@end
