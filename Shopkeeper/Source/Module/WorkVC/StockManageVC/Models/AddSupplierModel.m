//
//  AddSupplierModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddSupplierModel.h"
#import "AddStoreTableViewCell.h"
#import "InputTableViewCell.h"
#import "ChooseTableViewCell.h"


@implementation AddSupplierModel

+ (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewmodel = [[KKTableViewModel alloc]init];
    
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    [tableViewmodel addSetionModel:section];
    
    NSArray *titles = @[@"供应商",@"联系人",@"手机号码",@"所在地区",@"街道/村",@"详细地址"];
    NSArray *placeholders = @[@"请输入供应商名称",@"请输入联系人姓名",@"请输入手机号码",@"",@"",@"请输入详细地址"];
    NSArray *contentKeys = @[@"name",@"contactName",@"contactPhone",@"areaId",@"village",@"address"];
    NSArray *edits = @[@1,@1,@1,@0,@0,@1];
    
    for (NSInteger i = 0; i<titles.count; i++)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 75;
        cellModel.cellType = contentKeys[i];
        BOOL edit = [edits[i] boolValue];
        if (edit)
        {
            cellModel.cellClass = NSClassFromString(@"InputTableViewCell");
            InputTableViewCellModel *data = [InputTableViewCellModel new];
            data.title = titles[i];
            data.placeholder = placeholders[i];
            data.contentKey = contentKeys[i];
            cellModel.data = data;
            if ([data.contentKey isEqualToString:@"contactPhone"]) {
                
                data.keyBoardType = UIKeyboardTypeNumberPad;
                data.maxLength = 11;
            }
        }
        else
        {
            cellModel.cellClass = NSClassFromString(@"ChooseTableViewCell");
            ChooseTableViewCellModel *data = [ChooseTableViewCellModel new];
            data.title = titles[i];
            data.contentKey = contentKeys[i];
            cellModel.data = data;
            data.desc = [CMLinkTextViewItem attributeStringWithText:@"请选择" textFont:APPFONT(17) textColor:ColorWithHex(@"#8F8E94") textAlignment:NSTextAlignmentRight];// selec #F29700 100%

        }
        [section addCellModel:cellModel];
    }
    
    KKSectionModel *remarkSection = [KKSectionModel new];
    [tableViewmodel addSetionModel:remarkSection];
    KKCellModel *remarkCellModel = [KKCellModel new];
    remarkCellModel.height = 75;
    remarkCellModel.cellClass = NSClassFromString(@"InputTableViewCell");
    InputTableViewCellModel *data = [InputTableViewCellModel new];
    data.title = @"备注";
    data.placeholder = @"最多50个字";
    data.contentKey = @"remark";
    remarkCellModel.data = data;
    [remarkSection addCellModel:remarkCellModel];
    
    return tableViewmodel;
}



+ (NSDictionary*)getAddSupplierParam:(KKTableViewModel*)tableView
{
    NSMutableDictionary *param = @{}.mutableCopy;
    
    for (KKSectionModel *section in tableView.sectionDataList) {
        
        for (KKCellModel *cellModel in section.cellDataList)
        {
            AddStoreTableViewCellModel *dataModel = (AddStoreTableViewCellModel*)cellModel.data;
            [param setObject:dataModel.content forKey:dataModel.contentKey];
        }
    }

    return param;
}



@end
