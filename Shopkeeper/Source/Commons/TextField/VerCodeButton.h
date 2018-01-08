//
//  VerCodeButton.h
//  kakatrip
//
//  Created by caiming on 16/9/26.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VerCodeButton;

@protocol VerCodeButtonDelegate <NSObject>

- (void)verCodeButtonDidSelect:(VerCodeButton*)verCodeButton;

@end

@interface VerCodeButton : UIView


@property(nonatomic, weak)id<VerCodeButtonDelegate> delegate;


- (void)startTheTime:(NSTimeInterval)second;

- (void)endTheTiming;

@end
