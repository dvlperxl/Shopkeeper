//
//  RecipePackageDetailFooter.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipePackageDetailFooter : UITableViewHeaderFooterView

@end


@interface RecipePackageDetailFooterModel : NSObject

@property (nonatomic,copy) NSString *footerLeftTitle;
@property (nonatomic,copy) NSString *footerRightTitle;
@end
