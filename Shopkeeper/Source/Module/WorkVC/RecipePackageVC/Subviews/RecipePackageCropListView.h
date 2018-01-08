//
//  RecipePackageCropListView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipePackageCropModel;

@protocol RecipePackageCropListViewDelegate<NSObject>

- (void)recipePackageCropListViewDidSelectMenu:(RecipePackageCropModel*)model;

@end

@interface RecipePackageCropListView : UIView

@property(nonatomic,weak)id<RecipePackageCropListViewDelegate> delegate;

+ (instancetype)listViewWithCropList:(NSArray*)cropList;
- (void)showInSuperView:(UIView*)aView;

@end
