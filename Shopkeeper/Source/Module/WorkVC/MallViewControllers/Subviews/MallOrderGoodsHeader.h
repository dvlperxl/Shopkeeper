//
//  MallOrderGoodsHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MallOrderGoodsHeader;

@protocol MallOrderGoodsHeaderDelegate <NSObject>

- (void)goodsHeaderTapBackShopping:(MallOrderGoodsHeader *)header;
@end

@interface MallOrderGoodsHeader : UITableViewHeaderFooterView

@property (nonatomic,weak) id<MallOrderGoodsHeaderDelegate> delegate;
@end


@interface MallOrderGoodsHeaderModel : NSObject

@property (nonatomic,copy) NSString *headerTitle;
@property (nonatomic,assign) BOOL showShopping;
@end
