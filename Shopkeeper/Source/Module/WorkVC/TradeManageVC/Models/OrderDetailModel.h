//
//  OrderDetailModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property(nonatomic,readonly)NSDictionary *retail;
@property(nonatomic,strong)NSString *selectRetailId;
@property(nonatomic,assign)NSInteger reStatus;

+ (instancetype)orderDetailModel:(NSDictionary*)orderDetail orderStatus:(NSString*)status;

- (KKTableViewModel *)tableViewModel;
- (BOOL)showBottomView;

@end
