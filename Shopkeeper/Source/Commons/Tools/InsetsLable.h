//
//  InsetsLable.h
//  Whosv-SQClientV3
//
//  Created by Whosv on 15/5/6.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLable : UILabel

@property(nonatomic)UIEdgeInsets insets;

-(id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;

-(id)initWithInsets:(UIEdgeInsets)insets;

//-(void)setPointBackgroundColor:(UIColor *)color;


@end
