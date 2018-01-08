//
//  RecipePackageCropListViewModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipePackageCropListViewModel : NSObject

+ (KKTableViewModel*)categoryTableViewModel:(NSArray*)categoryList;
+ (void)setCategoryTableView:(KKTableViewModel*)tableViewModel
               cellIndexPath:(NSIndexPath*)indexPath
                    selected:(BOOL)selected;


@end


@interface RecipePackageCropModel : NSObject<YYModel>

@property(nonatomic,strong)NSNumber *cid;
@property(nonatomic,strong)NSNumber *isFruit;
@property(nonatomic,strong)NSNumber *pid;
@property(nonatomic,strong)NSNumber *storeCrop;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *groupStr;

+ (NSArray*)sectionGroups:(NSArray<RecipePackageCropModel*>*)modelList;

@end


