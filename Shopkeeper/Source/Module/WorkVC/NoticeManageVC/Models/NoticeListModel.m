//
//  NoticeListModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "NoticeListModel.h"
#import "NoticeListTableViewCell.h"

@implementation NoticeListModel

+ (KKTableViewModel *)tableViewModel:(NSArray*)noticeList
{
    KKTableViewModel *tableViewModel = [KKTableViewModel new];
    tableViewModel.noResultImageName = Default_nodata;

    for (NSDictionary *notice in noticeList)
    {
        KKSectionModel *sectionModel = [KKSectionModel new];
        [tableViewModel addSetionModel:sectionModel];
        sectionModel.footerData.height = 10;
        
        KKCellModel *cellModel = [KKCellModel new];
        [sectionModel addCellModel:cellModel];
        cellModel.height = 150;
        cellModel.cellClass = NSClassFromString(@"NoticeListTableViewCell");
        
        NoticeListTableViewCellModel *data = [NoticeListTableViewCellModel new];
        data.title = notice[@"title"];
        data.content = notice[@"mainBody"];
        data.time = notice[@"releaseTime"];
        
        NSString *status = @"已发送";
        NSNumber *reSend = notice[@"reSend"];
        UIColor *color = ColorWithRGB(153, 153, 153, 1);
        if (reSend.integerValue == 1)
        {
            status = @"待发送";
            color = ColorWithRGB(242, 151, 0, 1);
        }
        
        data.status =  [CMLinkTextViewItem attributeStringWithText:status textFont:APPFONT(15) textColor:color];
        cellModel.data = data;
        
        CGFloat titleHeight = [data.title calculateHeight:CGSizeMake(SCREEN_WIDTH-100, 10000) font:APPFONT(18)];
        CGFloat contentHeight = [data.content calculateHeight:CGSizeMake(SCREEN_WIDTH-30, 10000) font:APPFONT(15)];
        cellModel.height = 20+titleHeight+10+contentHeight+10+15+20;
    }
    
    return tableViewModel;
}

@end
