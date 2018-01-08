//
//  CommodityListCell.h
//  Dev
//
//  Created by xl on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityListCell : UITableViewCell

@end


@interface CommodityListCellModel : NSObject
@property (nonatomic,copy,readonly) NSString *commodityName;
@property (nonatomic,copy,readonly) NSString *commodityContent;
@property (nonatomic,copy,readonly) NSString *commodityPrice;
@property (nonatomic,copy,readonly) NSString *commodityId;

+ (instancetype)cellModelDataWithName:(NSString *)commodityName content:(NSString *)commodityContent price:(NSString *)commodityPrice commodityId:(NSString *)commodityId;
@end
