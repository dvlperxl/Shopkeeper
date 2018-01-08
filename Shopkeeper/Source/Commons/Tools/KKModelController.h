//
//  KKModelController.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/2.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKModelController : UIView

+ (instancetype)presentationControllerWithContentView:(UIView*)contentView;
- (void)showInSuperView:(UIView *)aView;
- (void)dismiss;

@end
