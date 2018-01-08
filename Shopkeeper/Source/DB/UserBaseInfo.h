//
//  UserBaseInfo.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserBaseInfo : NSObject<YYModel>

@property(nonatomic,strong)NSNumber *areaId;
@property(nonatomic,strong)NSNumber *uid;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *userRole;
@property(nonatomic,copy)NSString *userName;

SingletonH

- (void)logout;

@end
