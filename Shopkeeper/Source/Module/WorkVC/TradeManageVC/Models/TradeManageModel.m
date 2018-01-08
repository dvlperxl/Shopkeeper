//
//  TradeManageModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/16.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "TradeManageModel.h"
#import "TradeManageHomeCollectionViewCell.h"

@implementation TradeManageModel

+ (NSArray*)dataSource
{
    NSMutableArray *dataSource = @[].mutableCopy;
    
    NSArray *titles = @[
//  @[@"进货开单"],
  @[@"待确认订单",@"待支付订单",@"待送货订单",@"已收货订单",@"退货订单"]];
    NSArray *actionNames = @[
//  @[@"StockManageViewController"],
  @[@"OrderListViewController",@"OrderListViewController",@"OrderListViewController",@"OrderListViewController",@"OrderListViewController"]];

    NSArray *status = @[
//  @[@""],
  @[@"1",@"7",@"2",@"3",@"9"]];
    NSArray *images = @[
//  @[@"trade_icon_stock"],
  @[@"trade_home_menu_0",@"trade_home_menu_1",@"trade_home_menu_2",@"trade_home_menu_3",@"trade_home_menu_4"]];
    
    for (NSInteger i = 0; i<titles.count; i++)
    {
        NSArray *titleList = titles[i];
        NSArray *statusList = status[i];
        NSArray *imageList = images[i];
        NSArray *actionNameList = actionNames[i];


        NSMutableArray *dataList = @[].mutableCopy;
        NSInteger j;
        for (j = 0; j<titleList.count; j++)
        {
            TradeManageHomeCollectionViewCellModel *model = [TradeManageHomeCollectionViewCellModel new];
            model.title = titleList[j];
            model.iconImage = imageList[j];
            model.status = statusList[j];
            model.actionName = actionNameList[j];
            [dataList addObject:model];
        }
        
        NSInteger count = 3-j%3;
        
        if (count != 3)
        {
            for (NSInteger k = 0; k<count; k++)
            {
                    TradeManageHomeCollectionViewCellModel *positionModel = [TradeManageHomeCollectionViewCellModel new];
                    [dataList addObject:positionModel];
            }
        }
        
        [dataSource addObject:dataList];
    }

    return dataSource;
}

@end
