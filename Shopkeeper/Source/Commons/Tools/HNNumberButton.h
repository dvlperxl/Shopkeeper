//
//  HNNumberButton.h
//  Shopkeeper
//
//  Created by xl on 2017/11/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNNumberButton;

@protocol HNNumberButtonDelegate <NSObject>

@optional;
- (void)numberButton:(HNNumberButton *)numberButton errorNumber:(NSInteger)errorNumber;
- (void)numberButton:(HNNumberButton *)numberButton number:(NSInteger)number;
@end

@interface HNNumberButton : UIView

@property (nonatomic,assign) NSInteger currentNumber;
@property (nonatomic,assign) BOOL editing;
@property (nonatomic,weak) id <HNNumberButtonDelegate> delegate;
@property (nonatomic,assign) NSInteger minValue;
@property (nonatomic,assign) NSInteger maxValue;
@end
