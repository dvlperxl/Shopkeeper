//
//  RecipePackageCropListViewModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RecipePackageCropListViewModel.h"
#import "RecipePackageCropListViewCategoryCell.h"
#import "NSString+hn_extension.h"

@implementation RecipePackageCropListViewModel

+ (KKTableViewModel*)categoryTableViewModel:(NSArray*)categoryList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    
    for (NSDictionary *category in categoryList) {
        
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.cellClass = NSClassFromString(@"RecipePackageCropListViewCategoryCell");
        cellModel.height = 60;
        
        RecipePackageCropListViewCategoryCellModel *data = [RecipePackageCropListViewCategoryCellModel new];
        data.title = category[@"name"];
        data.selected = [categoryList.firstObject isEqual:category];
        cellModel.data = data;
        [sectionModel addCellModel:cellModel];
    }
    return tableViewModel;
}

+ (void)setCategoryTableView:(KKTableViewModel*)tableViewModel
               cellIndexPath:(NSIndexPath*)indexPath
                    selected:(BOOL)selected
{
    KKCellModel *cellModel = [tableViewModel cellModelAtIndexPath:indexPath];
    RecipePackageCropListViewCategoryCellModel *data = cellModel.data;
    data.selected = selected;
}

@end

@implementation RecipePackageCropModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"cid":@"id"};
}

- (NSString*)groupStr
{
    if (!_groupStr)
    {
        _groupStr = [self.name hn_firstLetter];
    }
    return _groupStr;
}

+ (NSArray*)sectionGroups:(NSArray<RecipePackageCropModel*>*)modelList
{
    NSMutableArray *array = @[].mutableCopy;
    for (RecipePackageCropModel *model in modelList) {
        
        if (![array containsObject:model.groupStr])
        {
            [array addObject:model.groupStr];
        }
    }
    return array.copy;
}

@end

