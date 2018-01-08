//
//  RecipePackageDetailTabFooter.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipePackageDetailTabFooter : UIView<HNReactView>

@end


@interface RecipePackageDetailTabFooterModel : NSObject

@property (nonatomic,copy) NSString *salePriceTitle;
@property (nonatomic,copy) NSString *salePriceContent;
@property (nonatomic,copy) NSString *integrationTitle;
@property (nonatomic,copy) NSString *integrationContent;
@property (nonatomic,copy) NSString *descriptionTitle;
@property (nonatomic,copy) NSString *descriptionContent;
@end
