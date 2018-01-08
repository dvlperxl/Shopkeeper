//
//  ReicpePackageAddPrescriptionTabFooter.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReicpePackageAddPrescriptionTabFooter;

@protocol ReicpePackageAddPrescriptionTabFooterDelegate <NSObject>

- (void)tapIntegrationRowTabFooter:(ReicpePackageAddPrescriptionTabFooter *)tabFooter;
@end

@interface ReicpePackageAddPrescriptionTabFooter : UIView<HNReactView>

@property (nonatomic,weak) id<ReicpePackageAddPrescriptionTabFooterDelegate> delegate;
@end


@interface ReicpePackageAddPrescriptionTabFooterModel : NSObject

@property (nonatomic,copy) NSString *salePriceTitle;
@property (nonatomic,copy) NSString *salePriceContent;
@property (nonatomic,copy) NSString *salePricePlaceholder;
@property (nonatomic,copy) NSString *integrationTitle;
@property (nonatomic,copy) NSString *integrationContent;
@property (nonatomic,copy) NSAttributedString *integrationPlaceholder;
@property (nonatomic,copy) NSString *descriptionTitle;
@property (nonatomic,copy) NSString *descriptionContent;
@property (nonatomic,copy) NSString *descriptionPlaceholder;
@end
