//
//  AddReceivePeopleModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddReceivePeopleModel : NSObject

+ (KKTableViewModel*)tableViewModelWithAddressDetail:(NSDictionary*)addressDetail;

+ (NSDictionary*)getAddReceivePeopleParam:(KKTableViewModel*)tableView;



@end
