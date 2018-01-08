//
//  ShoppingListBottomBar.h
//  Shopkeeper
//
//  Created by xl on 2017/12/8.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingListBottomBar;

@protocol ShoppingListBottomBarDelegate <NSObject>

- (void)bottomBar:(ShoppingListBottomBar *)bar tapSelectedAllStatus:(BOOL)status;
- (void)bottomBarTapPayBtn:(ShoppingListBottomBar *)bar;
@end

@interface ShoppingListBottomBar : UIView

@property (nonatomic,weak) id<ShoppingListBottomBarDelegate> delegate;
- (void)setAllSelectedTotalStatus:(BOOL)status;
- (void)setSelectedTotalPrice:(NSString*)totalPrice;
- (void)setSelectedCount:(NSInteger)selectedCount;
- (void)setPayBtnEnabled:(BOOL)enabled;
- (void)updateAllSelectedTotalStatus:(BOOL)status selectedTotalPrice:(NSString*)totalPrice selectedCount:(NSInteger)selectedCount payBtnEnabled:(BOOL)enabled;
@end
