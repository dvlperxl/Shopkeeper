//
//  NSAttributedString+AttributedString.h
//  kakatrip
//
//  Created by CaiMing on 2017/5/10.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (AttributedString)

-(CGFloat)calculateHeight:(CGSize)size;

- (NSAttributedString *)addLineBreakModeByTruncatingTail;

@end

