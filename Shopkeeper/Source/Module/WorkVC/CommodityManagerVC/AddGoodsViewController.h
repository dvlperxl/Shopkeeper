//
//  AddGoodsViewController.h
//  Dev
//
//  Created by xl on 2017/11/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//  新增商品页面

#import "BaseViewController.h"

@interface AddGoodsViewController : BaseViewController

@property(nonatomic,copy) NSString *storeId;
@property (nonatomic,strong) NSArray *categoryList;
@property (nonatomic,strong) NSDictionary *goodsDic;
@end
