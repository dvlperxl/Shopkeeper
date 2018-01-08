//
//  AreaDataModel.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/19.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "AreaDataModel.h"

@implementation AreaDataModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"uid":@"id"};
}

+ (NSArray*)getDefaultDisplayData:(NSArray<AreaDataModel*>*)list
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"type == '1'"];
    NSArray *result1 = [list filteredArrayUsingPredicate:pred];
    
    AreaDataModel *m1 = result1.firstObject;
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"pid == %d",m1.uid];
    NSArray *result2 = [list filteredArrayUsingPredicate:pred2];
    
    AreaDataModel *m2 = result2.firstObject;
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"pid == %d",m2.uid];
    NSArray *result3 = [list filteredArrayUsingPredicate:pred3];
    
    NSMutableArray *res = @[].mutableCopy;
    
    [res addObject:result1];
    [res addObject:result2];
    [res addObject:result3];
    
    return res.copy;
}

+ (NSArray *)getDefaultDisplayData:(NSArray<AreaDataModel*>*)list areaId:(NSNumber*)areaId
{
    
    
    if (areaId == nil) {
        
        return [self getDefaultDisplayData:list];
    }
    
    NSString *str = STRINGWITHOBJECT(areaId);
    
    if (str.length>6)
    {
        str = [str substringWithRange:NSMakeRange(0, 6)];
        areaId = [NSNumber numberWithLongLong:str.longLongValue];
    }
    
    if (str.length<6) {
        
        return [self getDefaultDisplayData:list];
        
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"type == '1'"];
    NSArray *result1 = [list filteredArrayUsingPredicate:pred];
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"pid == %d",areaId.integerValue/10000];
    NSArray *result2 = [list filteredArrayUsingPredicate:pred2];

    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"pid == %d",areaId.integerValue/100];
    NSArray *result3 = [list filteredArrayUsingPredicate:pred3];
    
    NSMutableArray *res = @[].mutableCopy;
    
    [res addObject:result1];
    [res addObject:result2];
    [res addObject:result3];
    
    if (result1.count==0||result2.count==0||result3.count==0)
    {
        return [self getDefaultDisplayData:list];
    }
    
    return res;
}


+ (NSArray *)queryAreaList:(NSArray<AreaDataModel*>*)list byPid:(NSInteger)pid
{
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"pid == %d",pid];
    NSArray *result3 = [list filteredArrayUsingPredicate:pred3];
    return result3;
}

+ (NSString *)queryAreaName:(NSArray<AreaDataModel*>*)list byArea:(NSInteger)areaId
{
    NSMutableArray *result = @[].mutableCopy;
    AreaDataModel *model;
    do {
        
        model = [self queryAreaDataModelByAreaId:areaId inAreaList:list];
        [result addObject:model];
        areaId = model.pid;
        NSLog(@"%@",model);
        
    } while (model);
    
    NSMutableString *str = [NSMutableString string];
    for (AreaDataModel *ad in [result.reverseObjectEnumerator allObjects])
    {
        [str appendString:ad.name];
         [str appendString:@" "];
    }
    return str;
}

+ (AreaDataModel*)queryAreaDataModelByAreaId:(NSInteger)areaId inAreaList:(NSArray<AreaDataModel*>*)list
{
    NSString *str = STRINGWITHOBJECT(@(areaId));
    if (str.length>6)
    {
        str = [str substringWithRange:NSMakeRange(0, 6)];
        areaId = (NSInteger)str.longLongValue;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"uid == %d",areaId];
    NSArray *result = [list filteredArrayUsingPredicate:pred];
    if (result.count>0)
    {
        AreaDataModel *model = result.firstObject;
        return model;
    }
    return nil;
}

@end
