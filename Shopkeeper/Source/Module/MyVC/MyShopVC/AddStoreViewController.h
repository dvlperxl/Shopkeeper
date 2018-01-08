//
//  AddStoreViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface AddStoreViewController : BaseViewController

@property(nonatomic,strong)NSNumber *storeId;//店ID
@property(nonatomic,copy)NSString *area;//省市区名称
@property(nonatomic,strong)NSNumber *areaId;//省市区编号名称
@property(nonatomic,copy)NSString *village;//村、街道 名称
@property(nonatomic,strong)NSNumber *villageId;//村、街道 名称
@property(nonatomic,copy)NSString *address;//详细地址
@property(nonatomic,copy)NSString *storeName;//门店名称

@end
