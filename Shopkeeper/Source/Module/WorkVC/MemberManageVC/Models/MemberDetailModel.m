//
//  MemberDetailModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberDetailModel.h"
#import "MemberDetailAddressCell.h"
#import "MemberDetailCropCell.h"
#import "MemberDetailTableViewCell.h"

@implementation MemberDetailModel

- (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    [tableViewModel addSetionModel:[self addressSection]];
    [tableViewModel addSetionModel:[self cropSection]];
    [tableViewModel addSetionModel:[self modeSection]];

    return tableViewModel;
}

- (KKSectionModel*)addressSection
{
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    
    KKCellModel *cellModel = [KKCellModel new];
    [section addCellModel:cellModel];
    cellModel.cellClass = NSClassFromString(@"MemberDetailAddressCell");
    cellModel.height = 95;
    
    MemberDetailAddressCellModel *data = [MemberDetailAddressCellModel new];
    cellModel.data = data;
    data.name = self.customer[@"customerNme"];
    
    
    NSDictionary *areaDto = self.customer[@"areaDto"];
    NSMutableString *area = [NSMutableString stringWithCapacity:1];
    
    if (areaDto[@"province"])
    {
        [area appendString:areaDto[@"province"]];
        [area appendString:@" "];

    }
    if (areaDto[@"city"]) {
        
        [area appendString:areaDto[@"city"]];
        [area appendString:@" "];

    }
    
    if (areaDto[@"district"]) {
        
        [area appendString:areaDto[@"district"]];
        [area appendString:@" "];

    }
    
    if (areaDto[@"town"]) {
        [area appendString:areaDto[@"town"]];
        [area appendString:@" "];
    }
    
    if (areaDto[@"village"]) {
        [area appendString:areaDto[@"village"]];
        [area appendString:@" "];
    }
    
    if (self.customer[@"address"])
    {
        [area appendString:self.customer[@"address"]];
    }
    
    data.address = area.copy;
    
//    data.showVip = [self.customer[@"isVip"] boolValue];
//    data.level = [NSString stringWithFormat:@"L%@会员",self.customer[@"level"]];

    return section;
}

- (KKCellModel*)noCropCell
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 92;
    cellModel.cellClass = NSClassFromString(@"MemberDetailNoCropCell");
    return cellModel;
}

- (KKSectionModel*)cropSection
{
    KKSectionModel *section = [KKSectionModel new];
    section.footerData.height = 10;
    section.headerData.cellClass = NSClassFromString(@"MemberDetailCropTableHeaderView");
    section.headerData.height = 40;

    NSMutableArray *cropList = self.crops.mutableCopy;
    
    while (cropList.count>0)
    {
        NSArray *sub;
        
        if (cropList.count>2)
        {
            sub = [cropList subarrayWithRange:NSMakeRange(0, 3)];
            [cropList removeObjectsInRange:NSMakeRange(0, 3)];
        }else
        {
            sub = [cropList subarrayWithRange:NSMakeRange(0, cropList.count)];
            [cropList removeObjectsInRange:NSMakeRange(0, cropList.count)];
        }
        [section addCellModel:[self cropCellModel:sub]];
    }
    
    if (section.cellDataList.count==0)
    {
        [section addCellModel:[self noCropCell]];
    }
    
    return section;
}

- (KKCellModel*)cropCellModel:(NSArray*)cropList
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 93;
    cellModel.cellClass = NSClassFromString(@"MemberDetailCropCell");
    
    NSMutableArray *datas = @[].mutableCopy;
    for (NSDictionary *crop in cropList) {
        
        MemberDetailCropViewModel *model =  [MemberDetailCropViewModel new];
        model.title = crop[@"cropName"];
        model.content = [NSString stringWithFormat:@"%@%@",crop[@"area"],crop[@"areaUnit"]];
        [datas addObject:model];
    }
    cellModel.data = datas;
    return cellModel;
}

- (KKSectionModel*)modeSection
{
    KKSectionModel *section = [KKSectionModel new];
    
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 76;
    cellModel.cellClass = NSClassFromString(@"MemberDetailTableViewCell");
    [section addCellModel:cellModel];
    
    MemberDetailTableViewCellModel *data = [MemberDetailTableViewCellModel new];
    data.iconName = @"ico_trade";
    data.title = @"消费记录";
    data.desc = [NSString stringWithFormat:@"%@笔",self.retailCount];
    cellModel.data = data;
    
    
    //ico_credit
    
    KKCellModel *creditCellModel = [KKCellModel new];
    creditCellModel.height = 76;
    creditCellModel.cellClass = NSClassFromString(@"MemberDetailTableViewCell");
    [section addCellModel:creditCellModel];
    
    MemberDetailTableViewCellModel *creditdata = [MemberDetailTableViewCellModel new];
    creditdata.iconName = @"ico_credit";
    creditdata.title = @"赊欠额";
    creditdata.desc = [NSString stringWithFormat:@"¥%@",self.customer[@"creditAmount"]];
    creditCellModel.data = creditdata;

    
    return section;
}



@end
