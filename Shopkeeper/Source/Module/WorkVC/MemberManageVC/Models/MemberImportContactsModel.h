//
//  MemberImportContactsModel.h
//  Dev
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CF_ENUM(NSInteger, ContactAuthorizationStatus) {
    ContactAuthorizationStatusNotDetermined = 0,
    ContactAuthorizationStatusRestricted,
    ContactAuthorizationStatusDenied,
    ContactAuthorizationStatusAuthorized
};

@interface MemberImportContactsModel : NSObject

+ (ContactAuthorizationStatus)authorizationStatus;

- (void)requestAccessWithCompletionHandler:(void (^)(BOOL granted, NSError *error))completionHandler;

- (void)getAddressBookDataSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;
/** 已存在的会员列表*/
- (void)existFarmerlist:(NSArray *)farmerList;
- (void)updateFarmerList;

/** tableViewModel*/
- (KKTableViewModel *)tableViewModel;
/** 可选择总个数*/
- (NSInteger)totalAvailableCount;
///** "ABCD...Z#"数组*/
//- (NSArray *)sectionIndexTitles;
/** 当前选中数组*/
- (NSArray *)selecteds;
/** 是否是全选状态*/
- (BOOL)isSelectedAllStatus;

- (NSString *)getInputList;
/** 选中单个*/
- (void)selectedCellDataModel:(id)cellData;
/** 选中全部*/
- (void)selectedAllStatus:(BOOL)selected;
@end
