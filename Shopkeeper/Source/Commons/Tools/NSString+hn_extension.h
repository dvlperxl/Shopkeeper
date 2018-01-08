//
//  NSString+hn_extension.h
//  Shopkeeper
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (hn_extension)

/** 中文转化为拼音*/
- (NSString *)hn_pinyin;

/** 拼音首字母*/
- (NSString *)hn_firstLetter;


- (BOOL)stringContainsEmoji;

@end
