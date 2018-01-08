//
//  AddSupplierModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddSupplierModel : NSObject

+ (KKTableViewModel*)tableViewModel;

+ (NSDictionary*)getAddSupplierParam:(KKTableViewModel*)tableView;

@end
