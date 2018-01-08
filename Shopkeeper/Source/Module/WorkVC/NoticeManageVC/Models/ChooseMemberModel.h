//
//  ChooseMemberModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseMemberModel : NSObject<YYModel>

@property(nonatomic,copy)NSString *customerNme;
@property(nonatomic,strong)NSNumber *amount;
@property(nonatomic,strong)NSNumber *creditAmount;
@property(nonatomic,copy)NSString *cropName;
@property(nonatomic,strong)NSNumber *customerId;
@property(nonatomic,strong)NSNumber *uid;

+ (KKTableViewModel*)tableViewModelWithMemberList:(NSArray<ChooseMemberModel*>*)memberList contacts:(NSString*)contacts;

+ (void)setSelectIndexPath:(NSIndexPath*)indexPath tableViewModel:(KKTableViewModel*)tableViewModel;

+ (NSInteger)getSelectCellCountWithTableViewModel:(KKTableViewModel*)tableViewModel;
+ (void)setAllCellSelectWithTableViewModel:(KKTableViewModel*)tableViewModel;
+ (void)removeAllCellSelectWithTableViewModel:(KKTableViewModel*)tableViewModel;

+ (NSString*)getChooseIdsWithTableViewModel:(KKTableViewModel*)tableViewModel;

@end
