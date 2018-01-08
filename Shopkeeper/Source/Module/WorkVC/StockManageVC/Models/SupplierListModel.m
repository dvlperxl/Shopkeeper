//
//  SupplierListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "SupplierListModel.h"
#import "SupplierListTableViewCell.h"

@implementation SupplierModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"contactName":@"contact_name",
             @"contactPhone":@"contact_phone",
             @"uid":@"id"};
}

- (KKCellModel*)cellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75;
    cellModel.cellClass = NSClassFromString(@"SupplierListTableViewCell");
    
    SupplierListTableViewCellModel *data = [SupplierListTableViewCellModel new];
    data.title = self.name;
    data.content = [NSString stringWithFormat:@"%@ %@",self.contactName,self.contactPhone];
    data.uid = self.uid;
    cellModel.data = data;
    
    return cellModel;
}

@end

@implementation SupplierListModel

+ (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_nodata;
    return tableViewModel;
}

+ (KKSectionModel*)sectionModelWithSupplierList:(NSArray*)supplierList
{
    KKSectionModel *sectionModel = [KKSectionModel new];
    NSArray *modelList = [SupplierModel modelObjectListWithArray:supplierList];
    for (SupplierModel *model in modelList)
    {
        [sectionModel addCellModel:[model cellModel]];
    }
    return sectionModel;
}


@end



