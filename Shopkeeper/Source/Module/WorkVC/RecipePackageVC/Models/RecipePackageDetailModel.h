//
//  RecipePackageDetailModel.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipePackageDetailTabHeader.h"
#import "RecipePackageDetailTabFooter.h"

@interface RecipePackageDetailModel : NSObject

@property(nonatomic,copy)NSString *cropName;

- (void)inputPrescriptionDic:(NSDictionary *)prescriptionDic;
// tableview数据源
- (RecipePackageDetailTabHeaderModel *)tabHeaderModel;
- (KKTableViewModel *)tableViewModel;
- (RecipePackageDetailTabFooterModel *)tabFooterModel;

- (NSDictionary *)prescriptionDic;
@end
