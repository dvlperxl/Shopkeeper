//
//  ChooseCardView.m
//  kakatrip
//
//  Created by caiming on 16/9/13.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import "ChooseCardTypeView.h"

@interface ChooseCardTypeView ()

@property(nonatomic,strong)UILabel *chooseLab;
@property(nonatomic,strong)NSArray *buttons;

@end

@implementation ChooseCardTypeView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initSubviewsWithArray:(NSArray*)titles
{
    CGFloat width = SCREEN_WIDTH/titles.count;
    CGFloat leftLeading = 0;
    self.chooseLab = [[UILabel alloc]init];
    self.chooseLab.backgroundColor = ColorWithHex(@"#F29700");
    self.chooseLab.layer.cornerRadius = 1.5;
    self.chooseLab.layer.masksToBounds = YES;
    [self addSubview:self.chooseLab];
    [self.chooseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.equalTo(@3);
        make.left.offset(leftLeading);
        make.width.equalTo(@(width));
    }];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    for (NSInteger i=0; i<titles.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = APPFONT(15);
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(width));
            make.left.offset(width*i);
            make.top.offset(0);
            make.height.equalTo(self);
        }];
        
        [array addObject:button];
    }
    self.buttons = array.copy;
    
    [self setSelectIndex:0];
    
}

-(void)setHeadTitleArray:(NSArray *)headTitleArray{

    if (self.buttons) {
        return;
    }
    if (headTitleArray) {
        _headTitleArray=headTitleArray;
        [self initSubviewsWithArray:headTitleArray];
    }
}
- (void)setSelectIndex:(NSUInteger)index
{
    if (index<self.buttons.count) {
        
        for (UIButton *button in self.buttons)
        {
            [button setTitleColor:ColorWithHex(@"#666666") forState:UIControlStateNormal];
        }
        
        UIButton *button = self.buttons[index];
        [button setTitleColor:ColorWithHex(@"#F29700") forState:UIControlStateNormal];
    }
    
    CGFloat width = SCREEN_WIDTH/_headTitleArray.count;
    CGFloat leftLeading = 0;
//    [UIView animateWithDuration:0.2 animations:^{
//
//
//
//
//    } completion:^(BOOL finished) {
//
//    }];
    
    [self.chooseLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(leftLeading+index*width);
    }];
    [self layoutIfNeeded];
    


    
}

- (void)onButtonAction:(UIButton *)button
{
    [self setSelectIndex:button.tag];
    if ([self.delegate respondsToSelector:@selector(chooseCardTypeView:didSelectIndex:)]) {
        
        [self.delegate chooseCardTypeView:self didSelectIndex:button.tag];
    }
}

@end
