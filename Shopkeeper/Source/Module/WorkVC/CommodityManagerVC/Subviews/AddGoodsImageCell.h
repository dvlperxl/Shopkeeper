//
//  AddGoodsImageCell.h
//  Shopkeeper
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddGoodsImageCell;

@protocol AddGoodsImageCellDelegate <NSObject>

- (void)addGoodsImageCellTapAddImage:(AddGoodsImageCell *)cell;
- (void)addGoodsImageCell:(AddGoodsImageCell *)cell deleteImageWithIndex:(NSInteger)index;
@end

@interface AddGoodsImageCell : UITableViewCell

@property (nonatomic,weak) id<AddGoodsImageCellDelegate> delegate;
@end
