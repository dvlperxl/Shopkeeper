//
//  KKPageControl.m
//  kakatrip
//
//  Created by CaiMing on 2017/4/12.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KKPageControl.h"

@interface KKPageControl ()

@property(nonatomic, strong)NSArray *points;
@property(nonatomic, assign)CGFloat pointWidth;
@property(nonatomic, assign)CGFloat spaceWidth;
@property(nonatomic, assign)CGFloat pointHeight;


@end

@implementation KKPageControl

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _pointWidth = 20;
        _spaceWidth = 9;
        _pointHeight = 5;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self initPoint];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    self.points = [self createPointWithCount:numberOfPages];
    [self initPoint];
}

- (NSArray *)createPointWithCount:(NSInteger)count
{
    [self removeAllPoints];
    NSMutableArray *array = @[].mutableCopy;

    CGFloat totalWith = count*self.pointWidth+(count-1)*self.spaceWidth;
    CGFloat x = (self.frame_width-totalWith)/2;
    CGFloat y = self.frame_height/2-self.pointHeight/2;
    
    for (NSInteger i = 0 ; i<count; i++) {
        
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(x+(self.pointWidth+self.spaceWidth)*i, y, self.pointWidth, self.pointHeight)];
        [array addObject:point];
    }
    
    return array.copy;
}

- (void)initPoint
{
    for (NSInteger i = 0;i<self.points.count;i++) {
        
        UIView *point = self.points[i];
        point.layer.masksToBounds = YES;
        point.layer.cornerRadius  = 2.5;
        point.layer.borderColor = ColorWithHex(@"e1e7ea").CGColor;
        point.layer.borderWidth = 1.0;
        [self addSubview:point];
        
        if (i==self.currentPage) {
            
            point.layer.backgroundColor = ColorWithHex(@"e1e7ea").CGColor;
        }else
        {
            point.layer.backgroundColor = [UIColor clearColor].CGColor;
        }
    }
}

- (void)removeAllPoints
{
    for (UIView *point in self.points) {
        
        [point removeFromSuperview];
    }
    
    self.points = nil;

}


@end
