//
//  InsetsLable.m
//  Whosv-SQClientV3
//
//  Created by Whosv on 15/5/6.
//  Copyright (c) 2015年 Jack. All rights reserved.
//

#import "InsetsLable.h"

@interface InsetsLable ()

@property(nonatomic, strong)UIView *pointV;

@end

@implementation InsetsLable

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.insets = UIEdgeInsetsMake(0, 12, 0, 0);
}

-(id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets
{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.insets= insets;
        
    }
    
    return self;
}




-(id)initWithInsets:(UIEdgeInsets)insets
{
    
    self  = [super init];
    
    if(self){
        
        self.insets = insets;
        
    }
    
    return  self;
    
}

-(void)drawTextInRect:(CGRect)rect {
    
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect,self.insets)];
    
}

//-(void)setPointBackgroundColor:(UIColor *)color
//{
//    [self addSubview:self.pointV];
////    self.pointV.backgroundColor = color;
//}

//- (UIView *)pointV
//{
//    if (!_pointV) {
//        
//        _pointV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
//        _pointV.backgroundColor = ColorWithHex(@"004171");
//
//        
//        _pointV.layer.masksToBounds = YES;
//        _pointV.layer.cornerRadius = 5;
//        _pointV.layer.borderColor = ColorWithHex(@"7598b1").CGColor;
//        _pointV.layer.borderWidth = 1.0;
//        
//    }
//    
//    return _pointV;
//}



@end
