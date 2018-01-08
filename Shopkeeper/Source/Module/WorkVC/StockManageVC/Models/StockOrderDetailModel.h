//
//  StockOrderDetailModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StockOrderDetailModel : NSObject

+ (KKTableViewModel*)tableViewModel:(NSDictionary*)orderDetail tag:(NSNumber *)tag status:(NSString*)status;

@end
