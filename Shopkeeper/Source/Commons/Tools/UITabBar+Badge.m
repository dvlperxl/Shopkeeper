//
//  UITabBar+Badge.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/1.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "UITabBar+Badge.h"

#define TabbarItemNums 4.0    //tabbar的数量 如果是5个设置为5.0


@implementation UITabBar (Badge)

//显示小红点
- (void)showBadgeOnItemIndex:(int)index count:(NSInteger)count
{

    UIButton *redPoint = [self getRedPointWithIndex:index];
    [self addSubview:redPoint];
    
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index +0.5) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height)-3;
    
    NSString *title = STRINGWITHOBJECT(@(count));
    if (count>99) {
        title = @"99+";
    }
    [redPoint setTitle:title forState:UIControlStateNormal];
    redPoint.frame = CGRectMake(x, y, 20, 20);
    [redPoint sizeToFit];
    CGRect rect = redPoint.frame;
    rect.size.height = 20;
    if (rect.size.width <20)
    {
        rect.size.width = 20;
    }
    redPoint.frame = rect;

    if (count<1) {
        
        [redPoint removeFromSuperview];
    }
}

- (UIButton*)getRedPointWithIndex:(NSInteger)index
{
    UIButton *redPointButton = [self viewWithTag:888+index];
    if (redPointButton == nil)
    {
        redPointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        redPointButton.backgroundColor = ColorWithHex(@"#FC6A21");
        [redPointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        redPointButton.titleLabel.font = APPFONT(12);
        redPointButton.layer.masksToBounds = YES;
        redPointButton.layer.cornerRadius = 10;
        redPointButton.tag = 888+index;
        [redPointButton setTitle:@"22" forState:UIControlStateNormal];
        redPointButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        [redPointButton sizeToFit];
        redPointButton.userInteractionEnabled = NO;
    }
    return redPointButton;
}



@end
