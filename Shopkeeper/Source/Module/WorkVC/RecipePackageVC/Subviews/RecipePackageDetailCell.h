//
//  RecipePackageDetailCell.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipePackageDetailCell : UITableViewCell

@end


@interface RecipePackageDetailCellModel : NSObject

@property (nonatomic,copy) NSString *goodsBrand;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *singlePrice;
@property (nonatomic,copy) NSString *goodsSpeci;
@property (nonatomic,copy) NSString *useSpcTitle;
@property (nonatomic,copy) NSString *useSpcContent;
@property (nonatomic,copy) NSString *useSpcUnit;
@property (nonatomic,assign) NSInteger goodsNumber;
@end
