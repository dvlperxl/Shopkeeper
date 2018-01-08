//
//  RecipePackageDetailViewController.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//  处方套餐详情页面

#import "BaseViewController.h"

@interface RecipePackageDetailViewController : BaseViewController

@property (nonatomic,copy) NSString *storeId;
/** 作物字典*/   // key: corpId 、corpName
@property (nonatomic,copy) NSNumber *cropId;
@property (nonatomic,copy) NSString *cropName;
// 套餐id
@property (nonatomic,copy) NSString *prescriptionId;
@end
