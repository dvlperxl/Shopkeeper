//
//  OrderListModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListModel : NSObject

+ (KKTableViewModel *)tableViewModel:(NSArray*)orderList status:(NSString*)status;

@end
