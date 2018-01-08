//
//  UIScrollView+Category.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/6.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "UIScrollView+Category.h"

@implementation UIScrollView (Category)

- (void)setContentInsetAdjustmentBehaviorNever
{
    if (@available(iOS 11.0, *))
    {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
