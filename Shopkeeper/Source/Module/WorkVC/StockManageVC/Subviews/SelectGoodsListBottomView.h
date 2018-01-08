//
//  SelectGoodsListBottomView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectGoodsListBottomViewDelegate<NSObject>

- (void)selectGoodsListBottomViewDeleteGoodsIndex:(NSInteger)index;
- (void)selectGoodsListBottomViewModifyGoodsIndex:(NSInteger)index;

@end

@interface SelectGoodsListBottomView : UIView

@property(nonatomic,weak)id<SelectGoodsListBottomViewDelegate> delegate;

- (void)reloadData:(NSMutableArray*)goodsList;
- (void)onTapAction;

@end
