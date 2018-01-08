//
//  HomeModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HomeModel.h"
#import "HomeTableViewCell.h"


@implementation HomeModel

+(KKTableViewModel*)tableViewModel:(NSNumber*)unreadCount
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    
    KKSectionModel *sectionModel = [KKSectionModel new];
    [tableViewModel addSetionModel:sectionModel];
    
    
    KKCellModel *cellModel1 =  [KKCellModel new];
    [sectionModel addCellModel:cellModel1];
    cellModel1.height = 75;
    cellModel1.cellClass = NSClassFromString(@"HomeTableViewCell");
    
    HomeTableViewCellModel *data1 = [HomeTableViewCellModel new];
    cellModel1.data = data1;
    
    data1.title = @"消息通知";
    data1.iconName = @"icon_alter";
//    data1.content = @"您有1笔订单待送货";
    
    NSDateFormatter  *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    
    data1.dateTime =  [formatter stringFromDate:[NSDate date]];
    data1.redPointCount = unreadCount;

    KKCellModel *cellModel2 =  [KKCellModel new];
    [sectionModel addCellModel:cellModel2];
    cellModel2.height = 75;
    cellModel2.cellClass = NSClassFromString(@"HomeTableViewCell");
    
    HomeTableViewCellModel *data2 = [HomeTableViewCellModel new];
    cellModel2.data = data2;
    
    data2.title = @"公告通知";
    data2.iconName = @"work_home_menu_2";
    data2.content = @"";
    data2.dateTime = @"";
    
    return tableViewModel;
}
@end
