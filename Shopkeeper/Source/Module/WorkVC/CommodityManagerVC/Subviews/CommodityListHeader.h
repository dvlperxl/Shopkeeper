//
//  CommodityListHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommodityListHeader;

@protocol CommodityListHeaderDelegate <NSObject>

- (void)tapHeader:(CommodityListHeader *)header;
@end

@interface CommodityListHeader : UITableViewHeaderFooterView

@property (nonatomic,weak) id<CommodityListHeaderDelegate> delegate;
@end


@interface CommodityListHeaderModel : NSObject

@property (nonatomic,copy,readonly) NSString *leftTitle;
@property (nonatomic,copy,readonly) NSString *rightTitle;
@property (nonatomic,copy,readonly) NSString *headerId;
+ (instancetype)headerModelWithLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle headerId:(NSString *)headerId;
@end
