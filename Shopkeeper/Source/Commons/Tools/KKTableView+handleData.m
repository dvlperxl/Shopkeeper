//
//  KKTableView+handleData.m
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "KKTableView+handleData.h"

@implementation KKTableView (handleData)

- (void)replaceDataModelForIndexPath:(NSIndexPath *)indexPath data:(id)data {
    if (!data) {
        return;
    }
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[indexPath.section];
    if (sectionModel) {
        NSArray *cellList = sectionModel.cellDataList;
        KKCellModel *cellModel = cellList[indexPath.row];
        if (cellModel && [cellModel.data isKindOfClass:[data class]]) {
            cellModel.data = data;
            [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}
- (void)deleteDataModelForIndexPath:(NSIndexPath *)indexPath {
    KKSectionModel *sectionModel = self.tableViewModel.sectionDataList[indexPath.section];
    if (sectionModel) {
        NSArray *cellList = sectionModel.cellDataList;
        KKCellModel *cellModel = cellList[indexPath.row];
        if (cellModel) {
            [sectionModel removeCellModel:cellModel];
            if (cellList.count == 0) {
                [self.tableViewModel.sectionDataList removeObject:sectionModel];
            }
            [self reloadData];
        }
    }
}
@end
