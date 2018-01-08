//
//  UITabBar+Badge.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index count:(NSInteger)count;   //显示小红点

@end
