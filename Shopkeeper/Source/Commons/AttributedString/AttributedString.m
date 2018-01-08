//
//  AttributedString.m
//  PalmDoctorPT
//
//  Created by caiming on 16/1/8.
//  Copyright © 2016年 kangmeng. All rights reserved.
//

#import "AttributedString.h"

@implementation AttributedString

+ (NSAttributedString *)attributeWithLinkTextViewItems:(NSArray *)linkTextViewItems
{
    NSMutableAttributedString *mAttributeString = [[NSMutableAttributedString alloc]initWithString:@""];
    
    NSUInteger location = 0;

    for (CMLinkTextViewItem *item in linkTextViewItems) {
        item.textRange = NSMakeRange(location, item.textContent.length);

        [mAttributeString appendAttributedString:[item attributeStringNormal]];
        location += item.textRange.length;

    }
    return mAttributeString;
}

@end


@interface CMLinkTextViewItem()


@end

@implementation CMLinkTextViewItem


+ (NSAttributedString*)attributeStringWithText:(NSString*)text textFont:(UIFont*)textFont textColor:(UIColor*)textColor
{
    CMLinkTextViewItem *item = [CMLinkTextViewItem new];
    item.textFont = textFont;
    item.textContent = text;
    item.textColor = textColor;
    return [item attributeStringNormal];
}

+ (NSAttributedString*)attributeStringWithText:(NSString*)text textFont:(UIFont*)textFont textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment
{
    CMLinkTextViewItem *item = [CMLinkTextViewItem new];
    item.textFont = textFont;
    item.textContent = text;
    item.textColor = textColor;
    item.textAlignment = textAlignment;
    return [item attributeStringNormal];
}

- (NSAttributedString *)attributeStringNormal;
{
    if (self.textContent == nil) {
        self.textContent = @"";
        
    }
    if (self.textColor == nil) {
        self.textColor = [UIColor whiteColor];
    }
    if (self.textFont == nil) {
        self.textFont = APPFONT(12);
    }
    UIColor *textColor = self.textColor;
    NSRange range = NSMakeRange(0, self.textContent.length);
    NSMutableAttributedString *sub = [[NSMutableAttributedString alloc]initWithString:self.textContent];
    [sub addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [sub addAttribute:NSFontAttributeName value:self.textFont range:range];
    if (_isUnderline) {
        
        [sub addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = _textAlignment;
    if (_lineSpacing>0)
    {
        paragraphStyle.lineSpacing = _lineSpacing;
    }
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [sub addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    return sub;
}

@end
