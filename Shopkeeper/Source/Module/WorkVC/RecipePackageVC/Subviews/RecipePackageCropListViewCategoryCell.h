//
//  RecipePackageCropListViewCategoryCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipePackageCropListViewCategoryCellModel;

@interface RecipePackageCropListViewCategoryCell : UITableViewCell

- (void)reloadData:(RecipePackageCropListViewCategoryCellModel*)model;

@end


@interface RecipePackageCropListViewCategoryCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL selected;

@end


