//
//  RecipePackageListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageListModel.h"
#import "RecipePackageListCell.h"
#import "RecipePackageListHeaderView.h"

@implementation RecipePackageListModel

+(KKTableViewModel*)tableViewModelWithRecipePackageList:(NSArray*)recipePackageList storeId:(NSNumber*)storeId
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_noproduct;
    
    for (NSDictionary*recipePackage in recipePackageList)
    {
        if ([recipePackage[@"prescriptions"] count]==0)
        {
            continue;
        }
        
        KKSectionModel *section = [KKSectionModel new];
        section.headerData.cellClass = NSClassFromString(@"RecipePackageListHeaderView");
        section.headerData.height = 110;
        RecipePackageListHeaderViewModel *data = [RecipePackageListHeaderViewModel new];
        section.headerData.data = data;
        data.imageURL =  recipePackage[@"largeImgUrl"];
        data.goodsName = recipePackage[@"corpName"];
        data.cropId = recipePackage[@"corpId"];
        data.goodsCount = [NSString stringWithFormat:@"共%@种",recipePackage[@"prescriptionNumber"]];
        [tableViewModel addSetionModel:section];
        
        for (NSDictionary *prescription in recipePackage[@"prescriptions"])
        {
            KKCellModel *cellModel = [KKCellModel new];
            [section addCellModel:cellModel];
            cellModel.cellClass = NSClassFromString(@"RecipePackageListCell");
            RecipePackageListCellModel *data = [RecipePackageListCellModel new];
            data.title = prescription[@"prescriptionName"];
            data.content = prescription[@"goodsNames"];
            NSString *salePrice = prescription[@"salePrice"];
            if (salePrice == nil) {
                salePrice=@"0";
            }
            data.amount = AMOUNTSTRING(salePrice);
            data.spec = STRING(prescription[@"prescriptionSpecName"], @"/套");
            data.goodsCount = STRING(prescription[@"goodsTypeNumber"], @"种商品");
            cellModel.data = data;
            
            cellModel.routerModel.className = @"RecipePackageDetailViewController";
            NSMutableDictionary *param = @{}.mutableCopy;
            
            [param setObject:recipePackage[@"corpId"] forKey:@"cropId"];
            [param setObject:recipePackage[@"corpName"] forKey:@"cropName"];
            [param setObject:prescription[@"prescriptionId"] forKey:@"prescriptionId"];
            [param setObject:storeId forKey:@"storeId"];
            cellModel.routerModel.param = param.copy;
            
        }
        
    }

    
    return tableViewModel;
}

@end
