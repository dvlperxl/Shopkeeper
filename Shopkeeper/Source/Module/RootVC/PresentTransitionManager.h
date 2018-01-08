//
//  PresentTransitionManager.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresentTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation   operation;

@end

