//
//  ShoppingListCell.h
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingListCell;

@protocol ShoppingListCellDelegate <NSObject>

- (void)shoppingCell:(ShoppingListCell *)cell errorNumber:(NSInteger)errorNumber;
- (void)shoppingCell:(ShoppingListCell *)cell number:(NSInteger)number;
- (void)shoppingCellDeleteHandle:(ShoppingListCell *)cell;
@end

@interface ShoppingListCell : UITableViewCell

@property (nonatomic,weak) id<ShoppingListCellDelegate> delegate;
@end


@interface ShoppingListCellModel : NSObject

@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,copy) NSString *goodsImage;
@property (nonatomic,copy) NSString *goodsContent;
@property (nonatomic,copy) NSString *goodsSpeci;
@property (nonatomic,copy) NSAttributedString *goodsPrice;
@property (nonatomic,strong) NSNumber *goodsNumber;

@property (nonatomic,strong)NSDictionary *goods;
@property (nonatomic,assign)BOOL select;

@end



