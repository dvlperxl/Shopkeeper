//
//  HNDataBase.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/18.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNDataBase.h"
#import <FMDB/FMDB.h>
#import "AreaDataModel.h"

@interface HNDataBase ()

@property(nonatomic,strong) FMDatabase *fmdb;
@property(nonatomic,strong) FMDatabaseQueue *queue;
@property(nonatomic,readwrite)NSArray *areaList;

@end

@implementation HNDataBase

/**
 *  单例
 *
 *  @ HNDataBase 对象
 */

SingletonM

- (instancetype)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}

- (NSArray *)areaList
{
    if (!_areaList)
    {
        NSLog(@"1");
        _areaList = [AreaDataModel modelObjectListWithArray:[self queryAllAreaData]];
        
        
        
        NSLog(@"2");
        
    }
    return _areaList;
}

- (NSArray*)queryAllAreaData
{
    [self.fmdb open];
    NSString *tableName = @"area_sc";
    NSString *sql = [NSString stringWithFormat:@"select *from '%@'",tableName];
    FMResultSet *result = [self.fmdb executeQuery:sql];
    NSMutableArray *mArr = @[].mutableCopy;
    while ([result next]) {
        [mArr addObject:[result resultDictionary]];
    }
    [self.fmdb close];
    return mArr.copy;
}

//- (NSArray*)queryAllAreaDataInQueue
//{
//    _queue = [FMDatabaseQueue databaseQueueWithPath:[self getAreaDataPath]];
//    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
//        NSString *tableName = @"area_sc";
//        NSString *sql = [NSString stringWithFormat:@"select *from '%@'",tableName];
//        FMResultSet *result = [self.fmdb executeQuery:sql];
//        while ([result next]) {
//            
////            NSLog(@"%ld", [result longForColumn:@"id"]);
//            
//        }
//        
//        NSLog(@"%@",[NSThread currentThread]);
//    }];
//    [_queue close];
//    
//    return nil;
//}


- (NSString *)getAreaDataPath
{
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area_v1.4.2" ofType:@"db"];
    NSURL *fileURL = [NSURL URLWithString:path];
    NSError *error = nil;
    NSString *cachesDir = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:fileURL.lastPathComponent];
    if (![fileManager fileExistsAtPath:cachesDir])
    {
        [fileManager copyItemAtPath:path toPath:cachesDir error:&error];
    }
    return cachesDir;
}

- (FMDatabase *)fmdb
{
    if (!_fmdb) {
        
        _fmdb = [FMDatabase databaseWithPath:[self getAreaDataPath]];
    }
    return _fmdb;
}

@end
