//
//  AreaDataModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaDataModel : NSObject<YYModel>

@property(nonatomic,assign)NSInteger uid;
@property(nonatomic,assign)NSInteger pid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *type;


+ (NSArray *)getDefaultDisplayData:(NSArray<AreaDataModel*>*)list;

+ (NSArray *)getDefaultDisplayData:(NSArray<AreaDataModel*>*)list areaId:(NSNumber*)areaId;

+ (NSArray *)queryAreaList:(NSArray<AreaDataModel*>*)list byPid:(NSInteger)pid;

+ (NSString *)queryAreaName:(NSArray<AreaDataModel*>*)list byArea:(NSInteger)areaId;

@end
