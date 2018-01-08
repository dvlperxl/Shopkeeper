//
//  NSObject+YYModel.h
//  kakatrip
//
//  Created by caiming on 16/9/29.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface NSObject (KaKaModel)

+ (NSArray*)modelObjectListWithArray:(NSArray *)array;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (void)modelObjectWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
- (NSArray *)getAllProperties;

@end
