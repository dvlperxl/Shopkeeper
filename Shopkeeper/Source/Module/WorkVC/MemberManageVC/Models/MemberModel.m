//
//  MemberModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberModel.h"
#import "MemberListTableViewCell.h"


@implementation MemberModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"customerId":@"id"};
}

+ (NSArray<KKCellModel*>*)cellModelList:(NSArray<MemberModel*>*)memberModelList
{
    NSMutableArray *cellList = @[].mutableCopy;
    for (MemberModel *model in memberModelList) {
        [cellList addObject:[model cellModel]];
    }
    return cellList.copy;
}

- (KKCellModel*)cellModel
{
    KKCellModel *cellModel = [KKCellModel new];
    cellModel.height = 75.0f;
    cellModel.cellClass = NSClassFromString(@"MemberListTableViewCell");
    
    MemberListTableViewCellModel *data = [MemberListTableViewCellModel new];
    cellModel.data = data;

    data.name = self.customerNme;
    
    data.score = [NSString stringWithFormat:@"%@积分",self.integration];
    data.con = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.amount)];
    data.credit = [NSString stringWithFormat:@"¥%@",AMOUNTSTRING(self.creditAmount)];
    data.customerId = self.customerId;
    return cellModel;
}


@end
