//
//  CMLinkTextView.h
//  CMLinkTextView
//
//  Created by caiming on 16/9/12.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributedString.h"

@class CMLinkTextView;

@protocol CMLinkTextViewDelegate <NSObject>

- (void)linkTextView:(CMLinkTextView *)textView selectIndex:(NSInteger)index;

@end

@interface CMLinkTextView : UITextView

@property(weak, nonatomic)id<CMLinkTextViewDelegate> cmDelegate;

- (CGFloat)reloadData:(NSArray *)linkTextViewItems;//


@end

