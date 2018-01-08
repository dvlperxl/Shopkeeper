//
//  ReicpePackageAddPrescriptionCell.h
//  Shopkeeper
//
//  Created by xl on 2017/11/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReicpePackageAddPrescriptionCell;

@protocol ReicpePackageAddPrescriptionCellDelegate <NSObject>

- (void)prescriptionCell:(ReicpePackageAddPrescriptionCell *)cell useSpcContent:(NSString *)useSpcContent;
- (void)prescriptionCell:(ReicpePackageAddPrescriptionCell *)cell number:(NSInteger)number;
@end

@interface ReicpePackageAddPrescriptionCell : UITableViewCell

@property (nonatomic,weak) id<ReicpePackageAddPrescriptionCellDelegate> delegate;
@end

@interface ReicpePackageAddPrescriptionCellModel : NSObject

@property (nonatomic,copy) NSString *goodsBrand;
@property (nonatomic,copy) NSString *goodsName;
@property (nonatomic,copy) NSString *singlePrice;
@property (nonatomic,copy) NSString *goodsSpeci;
@property (nonatomic,copy) NSString *useSpcTitle;
@property (nonatomic,copy) NSString *useSpcContent;
@property (nonatomic,copy) NSString *useSpcUnit;
@property (nonatomic,assign) NSInteger goodsNumber;
@end
