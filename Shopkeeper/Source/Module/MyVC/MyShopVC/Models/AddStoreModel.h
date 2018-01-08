//
//  AddStoreModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/22.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddStoreModel : NSObject

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,assign)BOOL eidtUserName;
@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *village;
@property(nonatomic,strong)NSString *address;

-(KKTableViewModel *)tableViewModel;

@end
