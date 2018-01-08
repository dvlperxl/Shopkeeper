//
//  RecipePackageListCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipePackageListCell : UITableViewCell

@end

@interface RecipePackageListCellModel : BaseCellModel

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *goodsCount;
@property(nonatomic,copy)NSString *spec;

@end
