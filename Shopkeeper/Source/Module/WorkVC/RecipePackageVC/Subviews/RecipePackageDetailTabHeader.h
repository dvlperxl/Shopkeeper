//
//  RecipePackageDetailTabHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReicpePackageDetailRowView : UIView

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end

@interface RecipePackageDetailTabHeader : UIView<HNReactView>

@end


@interface RecipePackageDetailTabHeaderModel : NSObject

@property (nonatomic,copy) NSString *prescriptionTitle;
@property (nonatomic,copy) NSString *prescriptionNameTitle;
@property (nonatomic,copy) NSString *prescriptionNameContent;
@property (nonatomic,copy) NSString *prescriptionSpecTitle;
@property (nonatomic,copy) NSString *prescriptionSpecContent;
@end
