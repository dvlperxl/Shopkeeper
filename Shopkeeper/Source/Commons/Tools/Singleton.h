//
//  Singleton.h
//  kakatrip
//
//  Created by caiming on 16/10/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#define SingletonH + (instancetype)share;


#define SingletonM \
static id instance_ = nil;\
+ (instancetype)share{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance_ = [[self alloc] init];\
});\
return instance_;\
}\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance_ = [super allocWithZone:zone];\
});\
return instance_;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return instance_;\
}