//
//  KKTableView+handleData.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "KKTableView.h"

@interface KKTableView (handleData)

- (void)replaceDataModelForIndexPath:(NSIndexPath *)indexPath data:(id)data;
- (void)deleteDataModelForIndexPath:(NSIndexPath *)indexPath;
@end
