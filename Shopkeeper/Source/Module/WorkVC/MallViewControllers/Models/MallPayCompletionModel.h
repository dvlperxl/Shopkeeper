//
//  MallPayCompletionModel.h
//  Shopkeeper
//
//  Created by xl on 2017/12/11.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallPayCompletionViewController.h"

@interface MallPayCompletionModel : NSObject

@property (nonatomic,assign) MallPayCompletionVCType payCompletionType;
@property (nonatomic,strong,readonly) UIImage *payStatusBg;
@property (nonatomic,strong,readonly) UIImage *payStatusIcon;
@property (nonatomic,copy,readonly) NSString *payStatus;
@property (nonatomic,copy,readonly) NSAttributedString *payToast;
@property (nonatomic,copy,readonly) NSString *payContentTitle;
@property (nonatomic,copy,readonly) NSString *payContentInfo;
@property (nonatomic,copy,readonly) NSString *payTypeTitle;
@property (nonatomic,copy,readonly) NSString *payTypeInfo;
@property (nonatomic,copy,readonly) NSString *leftBtnTitle;
@property (nonatomic,copy,readonly) NSString *rightBtnTitle;

@end
