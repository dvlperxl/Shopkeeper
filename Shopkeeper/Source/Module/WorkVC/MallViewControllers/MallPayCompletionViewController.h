//
//  MallPayCompletionViewController.h
//  Shopkeeper
//
//  Created by xl on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//  支付结束页面

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, MallPayCompletionVCType) {
    MallPayCompletionVCTypeSuccess = 0,        // 支付成功
    MallPayCompletionVCTypeFailure             // 支付失败
};

@interface MallPayCompletionViewController : BaseViewController

@property (nonatomic,strong) NSNumber *storeId;
@property (nonatomic,strong) NSNumber *payCompletionType;

@end
