//
//  BAHomeModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BAHomeModel.h"
#import "BAHomeTableViewCell.h"
#import "BAHomeTableViewCell.h"

@implementation BAHomeModel

+ (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    [tableViewModel addSetionModel:[self modeSection]];
    return tableViewModel;
}

+ (KKSectionModel*)modeSection
{
    KKSectionModel *section = [KKSectionModel new];
    
    NSArray *titles = @[@"每日对账",@"交易分析",@"会员分析",@"商品分析"];
    
    for (NSInteger i = 0; i<titles.count; i++)
    {
        KKCellModel *cellModel = [KKCellModel new];
        cellModel.height = 76;
        cellModel.cellClass = NSClassFromString(@"BAHomeTableViewCell");
        [section addCellModel:cellModel];
        
        BAHomeTableViewCellModel *data = [BAHomeTableViewCellModel new];
        data.iconName = [NSString stringWithFormat:@"ba_home_menu_%@",@(i)];
        data.title = titles[i];
        cellModel.data = data;
    }
    
    
    
    
    return section;
}



@end
