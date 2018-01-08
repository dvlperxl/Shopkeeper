//
//  XLSearchBar.m
//  123
//
//  Created by MacBook Pro on 16/1/7.
//  Copyright © 2016年 haoshenghuoLongXu. All rights reserved.
//

#import "XLSearchBar.h"

@implementation XLSearchBar


- (void)setXl_searchBarBgColor:(UIColor *)xl_searchBarBgColor {
    _xl_searchBarBgColor = xl_searchBarBgColor;
    [self layoutIfNeeded];
}
- (void)setXl_placeholderColor:(UIColor *)xl_placeholderColor {
    _xl_placeholderColor = xl_placeholderColor;
    [self layoutIfNeeded];
}
- (void)setXl_textColor:(UIColor *)xl_textColor {
    _xl_textColor = xl_textColor;
    [self layoutIfNeeded];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //通过遍历self.subviews找到searchField
   __block UITextField *searchField;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            searchField=obj;
            *stop=YES;
        }
    }];
    if (!searchField) {
        UIView *viewSelf=self.subviews[0];
        [viewSelf.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITextField class]]) {
                searchField=obj;
                *stop=YES;
            }
        }];
    }
    if (searchField) {
        //设置字体颜色
        if (self.xl_textColor) {
            searchField.textColor=self.xl_textColor;
        }
        if (self.xl_searchBarBgColor) {
            //设置背景颜色(设置背景颜色的时候必须将borderStyle设置为None，否则无效)
            [searchField setBackgroundColor:self.xl_searchBarBgColor];
            [searchField setBorderStyle:UITextBorderStyleNone];
            //改变textfield的边框颜色及圆角
//            searchField.layer.borderWidth=1;
//            searchField.layer.borderColor=[UIColor orangeColor].CGColor;
            searchField.layer.cornerRadius=5;
            searchField.layer.masksToBounds=YES;
        }
        if (self.xl_placeholderColor) {
            //设置placeholder的颜色
            [searchField setValue:self.xl_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        }
    }
}


@end
