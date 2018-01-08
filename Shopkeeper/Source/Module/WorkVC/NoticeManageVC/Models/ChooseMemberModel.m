//
//  ChooseMemberModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ChooseMemberModel.h"
#import "ChooseMemberTableViewCell.h"

@implementation ChooseMemberModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uid":@"id"};
}

+ (KKTableViewModel*)tableViewModelWithMemberList:(NSArray<ChooseMemberModel*>*)memberList contacts:(NSString*)contacts
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_nodata;
    tableViewModel.noResultTitle = @"没有会员信息";
    tableViewModel.noResultDesc= @"请至会员管理页面，新增或导入会员";
    KKSectionModel *section = [KKSectionModel new];
    section.headerData.height = 10;
    [tableViewModel addSetionModel:section];
    
    for (ChooseMemberModel *model in memberList)
    {
        [section addCellModel:[model cellModelWithContacts:contacts]];
    }
    
    return tableViewModel;
}

- (KKCellModel*)cellModelWithContacts:(NSString*)contacts
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75.0f;
    cellModel.cellClass = NSClassFromString(@"ChooseMemberTableViewCell");
    
    ChooseMemberTableViewCellModel *data = [ChooseMemberTableViewCellModel new];
    cellModel.data = data;
    
    data.title = self.customerNme;
    data.content = self.cropName;
    data.uid = STRINGWITHOBJECT(self.uid);
    data.select = [contacts containsString:data.uid];
    
    data.amount = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.amount)];
    data.amountDesc = @"交易金额";
    
    return cellModel;
}

+ (void)setSelectIndexPath:(NSIndexPath*)indexPath tableViewModel:(KKTableViewModel*)tableViewModel
{
    KKCellModel *cellModel = [tableViewModel cellModelAtIndexPath:indexPath];
    ChooseMemberTableViewCellModel *data = (ChooseMemberTableViewCellModel*)cellModel.data;
    data.select = !data.select;
}

+ (NSInteger)getSelectCellCountWithTableViewModel:(KKTableViewModel*)tableViewModel
{
    NSInteger count = 0;
    
    for (KKSectionModel *section in tableViewModel.sectionDataList)
    {
        for (KKCellModel *cellModel in section.cellDataList) {
            
            ChooseMemberTableViewCellModel *data = (ChooseMemberTableViewCellModel*)cellModel.data;
            if (data.select) {
                
                count ++;
            }
        }
    }
    
    return count;
}

+ (void)setAllCellSelectWithTableViewModel:(KKTableViewModel*)tableViewModel
{
    for (KKSectionModel *section in tableViewModel.sectionDataList)
    {
        for (KKCellModel *cellModel in section.cellDataList) {
            
            ChooseMemberTableViewCellModel *data = (ChooseMemberTableViewCellModel*)cellModel.data;
            data.select = YES;
        }
    }
}

+ (void)removeAllCellSelectWithTableViewModel:(KKTableViewModel*)tableViewModel
{
    for (KKSectionModel *section in tableViewModel.sectionDataList)
    {
        for (KKCellModel *cellModel in section.cellDataList) {
            
            ChooseMemberTableViewCellModel *data = (ChooseMemberTableViewCellModel*)cellModel.data;
            data.select = NO;
        }
    }
}

+ (NSString*)getChooseIdsWithTableViewModel:(KKTableViewModel*)tableViewModel
{
    NSMutableString *mStr = @"".mutableCopy;
    
    for (KKSectionModel *section in tableViewModel.sectionDataList)
    {
        for (KKCellModel *cellModel in section.cellDataList) {
            
            ChooseMemberTableViewCellModel *data = (ChooseMemberTableViewCellModel*)cellModel.data;
            if (data.select) {
                
                [mStr appendString:data.uid];
                [mStr appendString:@";"];
            }
        }
    }
    
    if ([mStr hasSuffix:@";"])
    {
        [mStr deleteCharactersInRange:NSMakeRange(mStr.length-1, 1)];
    }
    
    return mStr.copy;
}

@end
