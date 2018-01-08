//
//  SupplierListModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplierListModel : NSObject

+ (KKTableViewModel*)tableViewModel;
+ (KKSectionModel*)sectionModelWithSupplierList:(NSArray*)supplierList;

@end

@interface SupplierModel : NSObject<YYModel>

@property(nonatomic,copy)NSString *contactName;
@property(nonatomic,copy)NSString *contactPhone;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *uid;


@end
