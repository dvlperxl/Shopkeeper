//
//  RecipePackageChooseCropCollectionViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecipePackageChooseCropCollectionViewCellDelegate<NSObject>

- (void)recipePackageChooseCropCollectionViewCellDidSelect:(UICollectionViewCell*)aCell;

@end

@interface RecipePackageChooseCropCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)id<RecipePackageChooseCropCollectionViewCellDelegate> delegate;

- (void)reloadData:(NSString*)title;

@end
