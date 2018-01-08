//
//  AutoSizeLab.m
//  NewEBPP
//
//  Created by Jack on 14-12-9.
//  Copyright (c) 2014年 SHFFT. All rights reserved.
//

#import "AutoSizeLab.h"

@implementation AutoSizeLab

- (void)setText:(NSString *)text
{
    CGSize size = [self autoSizeLabNoLineSpacing:CGSizeMake(self.bounds.size.width, HUGE_VALL) withFont:self.font withSting:text];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    self.numberOfLines = 0;
    [super setText:text];
    
}

-(CGSize)autoSizeLabNoLineSpacing:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setObject:font forKey:NSFontAttributeName];
    NSAttributedString * attribute = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    CGRect  rect  = [attribute boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
//    CGRect  rect  = [attributedText boundingRectWithSize:CGSizeMake(self.frame_width, HUGE_VALL) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, rect.size.height);
//    self.numberOfLines = 0;
    [super setAttributedText:attributedText];
}

@end
