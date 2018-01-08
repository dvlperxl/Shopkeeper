//
//  TradeManageHomeCollectionViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TradeManageHomeCollectionViewCellModel;

@interface TradeManageHomeCollectionViewCell : UICollectionViewCell

- (void)reloadData:(TradeManageHomeCollectionViewCellModel*)model;

@end

@interface TradeManageHomeCollectionViewCellModel : NSObject

@property(nonatomic,copy)NSString *iconImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)RouterModel *routerModel;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *actionName;

@end
