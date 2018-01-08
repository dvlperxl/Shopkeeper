//
//  NSObject+YYModel.m
//  kakatrip
//
//  Created by caiming on 16/9/29.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "NSObject+KaKaModel.h"


@implementation NSObject (KaKaModel)

+ (NSArray*)modelObjectListWithArray:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]]) {
        
        return @[];
    }
    NSMutableArray *mArr = [NSMutableArray array];

    for (NSDictionary *dict in array) {
        
        NSObject *model = [[self class] modelObjectWithDictionary:dict];
        
        [mArr addObject:model];
    }
    
    return mArr.copy;
    
}
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    NSObject *model = [[self alloc]init];
    [model yy_modelSetWithDictionary:dict];
    return model;
}
- (void)modelObjectWithDictionary:(NSDictionary *)dict
{
    [self yy_modelSetWithDictionary:dict];
}

- (NSDictionary *)dictionaryRepresentation
{
    
    return [self properties:[self getAllProperties]];
}

/**
 *  获取对象的所有属性，不包括属性值
 *
 *  @return 获取对象的所有属性，不包括属性值
 */

- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


/**
 *  获取对象的所有属性 以及属性值
 *
 *  @return 获取对象的所有属性 以及属性值
 */

- (NSDictionary *)properties:(NSArray *)properties
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int i;
    for (i = 0; i<properties.count; i++)
    {
        NSString *propertyName = [properties objectAtIndex:i];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    return props;
}


@end
