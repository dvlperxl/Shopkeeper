//
//  ReicpePackageAddPrescriptionTabHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReicpePackageAddPrescriptionTabHeader;

@protocol ReicpePackageAddPrescriptionTabHeaderDelegate <NSObject>

- (void)tapSpecRowTabHeader:(ReicpePackageAddPrescriptionTabHeader *)tabHeader;
@end

@interface ReicpePackageAddPrescriptionTabHeader : UIView<HNReactView>

@property (nonatomic,weak) id<ReicpePackageAddPrescriptionTabHeaderDelegate> delegate;
@end


@interface ReicpePackageAddPrescriptionTabHeaderModel : NSObject

@property (nonatomic,copy) NSString *prescriptionTitle;
@property (nonatomic,copy) NSString *prescriptionNameTitle;
@property (nonatomic,copy) NSString *prescriptionNamePlaceholder;
@property (nonatomic,copy) NSString *prescriptionNameContent;
@property (nonatomic,copy) NSString *prescriptionSpecTitle;
@property (nonatomic,copy) NSString *prescriptionSpecContent;
@property (nonatomic,copy) NSAttributedString *rightPlaceholder;
@end
