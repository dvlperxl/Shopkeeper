//
//  SelectGoodsListView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/21.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectGoodsListViewDelegate<NSObject>

- (void)selectGoodsListViewDidDeleteCellWithIndexPath:(NSIndexPath*)indexPath;
- (void)selectGoodsListViewDidModifyCellWithIndexPath:(NSIndexPath*)indexPath;

@end

@interface SelectGoodsListView : UIView

@property(nonatomic,weak)id<SelectGoodsListViewDelegate> delegate;

- (void)reloadData:(KKTableViewModel*)tableViewModel;
- (void)showInCenterWithSuperView:(UIView *)aView;
- (void)dismiss:(void (^)(void))completionBlock;

@end


@class StockGoodsListTableViewCellModel;
@interface SelectGoodsListViewModel : NSObject

+ (KKTableViewModel *)tableViewModel:(NSArray<StockGoodsListTableViewCellModel*>*)list;

@end
