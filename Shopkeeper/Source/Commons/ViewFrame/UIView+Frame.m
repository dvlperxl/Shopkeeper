//
//  UIView+Frame.m
//  Children
//
//  Created by caiming on 15/5/14.
//  Copyright (c) 2015年 caiming. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)frame_x
{
    return self.frame.origin.x;
}
- (void)setFrame_X:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width,self.frame.size.height);
}

- (CGFloat)frame_y
{
    return self.frame.origin.y;
}

- (void)setFrame_Y:(CGFloat)y
{
    self.frame  = CGRectMake(self.frame_x, y, self.frame.size.width,self.frame.size.height);
}

- (CGFloat)frame_width
{
    return self.frame.size.width;
}
- (void)setFrame_Width:(CGFloat)width
{
    self.frame = CGRectMake(self.frame_x, self.frame_y, width, self.frame.size.height);
}

- (CGFloat)frame_height
{
    return self.frame.size.height;
}

- (void)setFrame_Height:(CGFloat)height
{
    self.frame = CGRectMake(self.frame_x, self.frame_y, self.frame.size.width, height);
}

- (CGFloat)frame_maxY
{
    return self.frame_y + self.frame.size.height;
}
- (CGFloat)frame_maxX
{
    return self.frame_x + self.frame.size.width;
}
- (CGPoint)boundsCenter
{
    return CGPointMake(self.frame_width/2, self.frame_height/2);
}


@end
