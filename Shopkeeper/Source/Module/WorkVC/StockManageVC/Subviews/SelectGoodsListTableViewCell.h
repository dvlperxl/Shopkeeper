//
//  SelectGoodsListTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockGoodsListTableViewCellModel;

@protocol SelectGoodsListTableViewCellDelegate<NSObject>

- (void)selectGoodsListTableViewCellDidSelectModifyButton:(UITableViewCell*)aCell;

@end

@interface SelectGoodsListTableViewCell : UITableViewCell

@property(nonatomic,weak)id<SelectGoodsListTableViewCellDelegate> delegate;

@end

