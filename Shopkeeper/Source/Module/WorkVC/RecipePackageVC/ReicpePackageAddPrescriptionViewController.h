//
//  ReicpePackageAddPrescriptionViewController.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//  新建/编辑 处方套餐页面

#import "BaseViewController.h"

@interface ReicpePackageAddPrescriptionViewController : BaseViewController

@property (nonatomic,copy) NSString *storeId;
/** 作物字典*/   // key: corpId 、corpName
@property (nonatomic,copy) NSNumber *cropId;
@property (nonatomic,copy) NSString *cropName;
@property (nonatomic,copy) NSDictionary *prescriptionDic;

@end
