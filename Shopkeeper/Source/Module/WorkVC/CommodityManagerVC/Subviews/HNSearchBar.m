//
//  HNSearchBar.m
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "HNSearchBar.h"

CGFloat const hn_searchRightSpace = 10.0f;

@implementation HNSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupProperty];
    }
    return self;
}

- (void)setupProperty {
    [self setImage:[UIImage imageNamed:@"serchBar"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"searchbarClearIcon"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    //    self.placeholder = @"搜索课程";
    self.xl_textColor = [UIColor blackColor];
    self.xl_searchBarBgColor = [UIColor colorWithHexString:@"#F5F5F5"];
    //    self.xl_placeholderColor=[UIColor grayColor];
    //设置searchbarstyle属性为minimal，只显示搜索框，外面的边框隐藏
    self.searchBarStyle = UISearchBarStyleMinimal;
    //设置光标的颜色
    [self setTintColor:[UIColor colorWithHexString:@"#F29700"]];
}

- (void)setFrame:(CGRect)frame {
    CGRect rect = frame;
    rect.size.width -= hn_searchRightSpace;
    [super setFrame:rect];
}

@end
