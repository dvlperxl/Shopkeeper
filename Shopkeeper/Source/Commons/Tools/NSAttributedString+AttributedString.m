//
//  NSAttributedString+AttributedString.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/10.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "NSAttributedString+AttributedString.h"

@implementation NSAttributedString (AttributedString)

-(CGFloat)calculateHeight:(CGSize)size
{
    CGRect  rect  = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height+1;
}

- (NSAttributedString *)addLineBreakModeByTruncatingTail
{
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc]initWithAttributedString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSRange range = NSMakeRange(0, self.length);
    [mas addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return mas.copy;
}
@end
