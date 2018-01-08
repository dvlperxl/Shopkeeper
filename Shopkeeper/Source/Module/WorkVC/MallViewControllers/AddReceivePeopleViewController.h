//
//  AddReceivePeopleViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface AddReceivePeopleViewController : BaseViewController

@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,copy)NSString *addressId;
@property(nonatomic,strong)NSDictionary *address;
@property(nonatomic,strong)NSNumber *state;

@end
