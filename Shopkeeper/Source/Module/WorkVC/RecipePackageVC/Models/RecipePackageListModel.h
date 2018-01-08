//
//  RecipePackageListModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipePackageListModel : NSObject

+(KKTableViewModel*)tableViewModelWithRecipePackageList:(NSArray*)recipePackageList storeId:(NSNumber*)storeId;

@end
