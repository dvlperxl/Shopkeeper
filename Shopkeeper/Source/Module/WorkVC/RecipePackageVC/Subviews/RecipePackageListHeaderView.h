//
//  RecipePackageListHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/29.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecipePackageListHeaderViewDelegate<NSObject>

- (void)recipePackageListHeaderViewDidSelectWithCropId:(NSNumber*)cropId cropName:(NSString*)cropName;

@end

@interface RecipePackageListHeaderView : UITableViewHeaderFooterView

@property(nonatomic,weak)id<RecipePackageListHeaderViewDelegate> delegate;

@end

@interface RecipePackageListHeaderViewModel : NSObject

@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,copy)NSString *goodsName;
@property(nonatomic,copy)NSString *goodsCount;
@property(nonatomic,copy)NSNumber *cropId;

@end
