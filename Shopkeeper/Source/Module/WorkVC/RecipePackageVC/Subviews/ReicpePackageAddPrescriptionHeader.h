//
//  ReicpePackageAddPrescriptionHeader.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReicpePackageAddPrescriptionHeader;

@protocol ReicpePackageAddPrescriptionHeaderDelegate <NSObject>

- (void)tapSectionHeader:(ReicpePackageAddPrescriptionHeader *)sectionHeader;
@end

@interface ReicpePackageAddPrescriptionHeader : UITableViewHeaderFooterView

@property (nonatomic,weak) id<ReicpePackageAddPrescriptionHeaderDelegate> delegate;
@end

@interface ReicpePackageAddPrescriptionHeaderModel : NSObject

@property (nonatomic,copy) NSString *headerLeftTitle;
@property (nonatomic,copy) NSAttributedString *headerMiddleTitle;
@property (nonatomic,copy) NSAttributedString *headerRightTitle;
@end
