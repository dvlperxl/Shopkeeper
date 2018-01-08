//
//  ReceivePersonListModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceivePersonListModel : NSObject

- (KKTableViewModel*)tableViewModel:(NSArray*)addressList storeId:(NSNumber*)storeId selectAddressId:(NSString*)addressId;

@end
