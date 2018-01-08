//
//  StockGoodsListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  StockGoodsListTableViewCellModel;

@protocol StockGoodsListTableViewCellDelegate <NSObject>

- (void)stockGoodsListTableViewCell:(UITableViewCell*)aCell didSelectAddButtonWithModel:(StockGoodsListTableViewCellModel*)model;

@end

@interface StockGoodsListTableViewCell : UITableViewCell

@property(nonatomic,weak)id<StockGoodsListTableViewCellDelegate> delegate;

@end

@interface StockGoodsListTableViewCellModel : NSObject<YYModel>

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSAttributedString *amount;
@property(nonatomic,copy)NSString *goodsId;
@property(nonatomic,copy)NSString *inputSale;
@property(nonatomic,strong)NSNumber *outputSale;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *total;

- (NSDictionary*)toDictionary;

@end
