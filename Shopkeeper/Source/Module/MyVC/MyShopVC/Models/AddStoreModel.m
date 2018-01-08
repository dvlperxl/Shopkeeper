//
//  AddStoreModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AddStoreModel.h"
#import "AddStoreTableViewCell.h"
#import "InputTableViewCell.h"
#import "ChooseTableViewCell.h"

@implementation AddStoreModel

-(KKTableViewModel *)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    NSArray *titles = @[@"店主姓名",@"门店名称",@"所在地区",@"街道/村",@"详细地址"];
    NSArray *placeholders = @[@"请输入你的真实姓名",@"请输入店名，如桥头农技服务中心",@"",@"",@"请输入详细地址"];
    NSArray *contentKeys = @[@"userName",@"storeName",@"areaId",@"village",@"address"];
    NSMutableArray *contents = @[].mutableCopy;
    [self ma:contents addObject:self.userName];
    [self ma:contents addObject:self.storeName];
    [self ma:contents addObject:self.area];
    [self ma:contents addObject:self.village];
    [self ma:contents addObject:self.address];
    
    NSArray *edits = @[@0,@1,@0,@0,@1];
    if (self.eidtUserName) {
         edits = @[@1,@1,@0,@0,@1];
    }
    NSArray *chooses = @[@0,@0,@1,@1,@0];
    
    KKSectionModel *section = [KKSectionModel new];
    [tableViewModel addSetionModel:section];
    
    for (NSInteger i = 0;i<titles.count;i++)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 50;
        cellModel.cellType = contentKeys[i];
        cellModel.cellClass = NSClassFromString(@"AddStoreTableViewCell");
        AddStoreTableViewCellModel *data = [AddStoreTableViewCellModel new];
        data.title = titles[i];
        data.placeholder = placeholders[i];
        data.contentKey = contentKeys[i];
        data.content = contents[i];
        cellModel.data = data;

        BOOL edit = [edits[i] boolValue];
        data.edit = edit;
        BOOL choose = [chooses[i] boolValue];
        data.choose = choose;
        [section addCellModel:cellModel];
    }
    
    if (self.storeId) {
        KKSectionModel *section = [KKSectionModel new];
        section.headerData.height = 10;
        [tableViewModel addSetionModel:section];
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 75;
        cellModel.cellClass = NSClassFromString(@"AddStoreQrCodeCell");
        [section addCellModel:cellModel];
    }
    
    return tableViewModel;

}

- (void)ma:(NSMutableArray*)ma addObject:(NSString*)obj
{
    if (obj== nil) {
        obj = @"";
    }
    [ma addObject:obj];
}

@end
