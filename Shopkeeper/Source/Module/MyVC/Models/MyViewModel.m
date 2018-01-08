//
//  MyViewModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import "MyViewModel.h"
#import "MyTableViewCell.h"

@implementation MyViewModel

+ (KKTableViewModel*)tableViewModel
{
    KKTableViewModel *tableViewModel = [[KKTableViewModel alloc]init];
    
    NSArray *images = @[@[@"ico_mystore",@"ico_sms"],@[@"ico_intro"],@[@"ico_aboutus",@"ico_setting"]];
    NSArray *titles = @[@[@"我的门店",@"短信充值"],@[@"服务中心"],@[@"关于我们",@"设置"]];
    NSArray *classNames = @[@[@"MyShopListViewController",@"SMSRechargeViewController"],@[@"ServiceCenterViewController"],@[@"AboutUSViewController",@"AboutUSViewController"]];
    
    for (NSInteger i = 0;i<images.count;i++)
    {
        KKSectionModel *section = [KKSectionModel new];
        section.headerData.height = 10;
        NSArray *arr = images[i];
        for (NSInteger j = 0; j<arr.count; j++) {
            
            KKCellModel *cellModel = [KKCellModel new];
            cellModel.height = 75;
            cellModel.cellClass = NSClassFromString(@"MyTableViewCell");
            cellModel.cellType = titles[i][j];
            MyTableViewCellModel *data = [MyTableViewCellModel new];
            data.iconImageName =images[i][j];
            data.content = titles[i][j];
            cellModel.data = data;
            [section addCellModel:cellModel];
            
            cellModel.routerModel.className = classNames[i][j];
            cellModel.routerModel.param = @{@"leftButtonTitle":@"我的"};
            
            if (j == arr.count-1) {
                data.hideLine = YES;
            }
            
        }
        [tableViewModel addSetionModel:section];
    }
    
    return tableViewModel;
}

@end
