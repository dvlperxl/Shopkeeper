//
//  KKModelController.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/2.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KKModelController.h"
#import <WebKit/WebKit.h>
#import "InsetsLable.h"

@interface KKModelController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITapGestureRecognizer * tap;

@end

@implementation KKModelController

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
    }
    return self;
}

+ (instancetype)presentationControllerWithContentView:(UIView*)contentView
{
    KKModelController *presentation = [[KKModelController alloc]initWithFrame:CGRectZero];
    presentation.contentView = contentView;
    return presentation;
}

- (void)showInSuperView:(UIView *)aView
{
    [aView addSubview:self];
    
    [self addSubview:self.contentView];
    if (self.contentView) {
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.offset(0);
            make.height.mas_equalTo(self.contentView.frame_height);
        }];
    }
    
    self.alpha = 0;
    
    self.contentView.transform = CGAffineTransformIdentity;
    
    self.contentView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT-172);
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 1;
                         self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);

                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 0;
                         self.contentView.transform = CGAffineTransformMakeTranslation(0,SCREEN_HEIGHT-172);

                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                     }];
}


#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - initSubviews

- (void)initSubviews
{
    self.frame = SCREEN_BOUNDS;
    self.backgroundColor = [ColorWithHex(@"1f293e") colorWithAlphaComponent:0.6];
    [self addGestureRecognizer:self.tap];
}


-(UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        _tap.delegate = self;
    }
    
    return _tap;
}

@end
