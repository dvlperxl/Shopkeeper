//
//  KKPresentationController.m
//  kakatrip
//
//  Created by CaiMing on 2017/5/2.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "KKPresentationController.h"
#import <WebKit/WebKit.h>

@interface KKPresentationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *alertView;
@property(nonatomic,strong)UIButton *closeButton;
@property(nonatomic,strong)UIView *tooBarView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *URLStr;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITapGestureRecognizer * tap;

@end

@implementation KKPresentationController

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
    }
    return self;
}


+ (instancetype)presentationControllerWithTitle:(NSString*)title url:(NSString*)urlString
{
    KKPresentationController *presentation = [[KKPresentationController alloc]initWithFrame:CGRectZero];
    presentation.title = title;
    presentation.URLStr = urlString;
    
    return presentation;
}

+ (instancetype)presentationControllerWithContentView:(UIView*)contentView
{
    KKPresentationController *presentation = [[KKPresentationController alloc]initWithFrame:CGRectZero];
    presentation.contentView = contentView;
    return presentation;
}

+ (instancetype)presentationControllerWithTitle:(NSString*)title contentView:(UIView*)contentView
{
    KKPresentationController *presentation = [[KKPresentationController alloc]initWithFrame:CGRectZero];
    presentation.title = title;
    presentation.contentView = contentView;
    return presentation;
}

- (void)showInSuperViewBottom:(UIView *)aView
{
    [aView addSubview:self];
    
    if (self.title) {
        self.titleLabel.text = self.title;
    }
    
    if (self.URLStr) {
        
        [self.alertView addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(40);
            make.left.right.bottom.offset(0);
        }];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]]];
        
    }
    
    if (self.contentView) {
        
        [self.alertView addSubview:self.contentView];
        
        CGFloat height = CGRectGetHeight(self.contentView.frame);
        
        if (height<96)
        {
            [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(10);
                make.right.offset(-10);
                //                make.bottom.offset(-10);
                make.height.mas_equalTo(136);
                make.centerY.equalTo(self.mas_centerY);
                
            }];
        }else if (height<SCREEN_HEIGHT-182)
        {
            [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(10);
                make.right.offset(-10);
                //                make.bottom.offset(-10);
                make.height.mas_equalTo(height+40);
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(40);
            make.left.right.bottom.offset(0);
        }];
    }
    
    
    
    self.alpha = 0;
    
    self.alertView.transform = CGAffineTransformIdentity;
    
    self.alertView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT-172);
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 1;
                         self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    

}
- (void)showInSuperView:(UIView *)aView animation:(BOOL)animation
{
    [aView addSubview:self];
    
    if (self.title) {
        self.titleLabel.text = self.title;
    }
    
    if (self.URLStr) {
        
        [self.alertView addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(40);
            make.left.right.bottom.offset(0);
        }];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]]];
    }
    
    if (self.contentView) {
        
        [self.alertView addSubview:self.contentView];
        
        CGFloat height = CGRectGetHeight(self.contentView.frame);
        
        if (height<96)
        {
            [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(30);
                make.right.offset(-30);
                //                make.bottom.offset(-10);
                make.height.mas_equalTo(136);
                make.centerY.equalTo(self.mas_centerY);
                
            }];
        }else if (height<SCREEN_HEIGHT-82)
        {
            [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(30);
                make.right.offset(-30);
                //                make.bottom.offset(-10);
                make.height.mas_equalTo(height);
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(0);
            make.left.right.bottom.offset(0);
        }];
    }
    
    
    if (animation) {
        
        self.alpha = 0;
        
        self.alertView.transform = CGAffineTransformIdentity;
        
        self.alertView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT-172);
        
        [UIView animateWithDuration:0.15
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             self.alpha = 1;
                             self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
    }else
    {
        self.alpha = 1;
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    }
    
}

- (void)showInSuperView:(UIView *)aView
{
    [self showInSuperView:aView animation:YES];
}

- (void)showInCenterWithSuperView:(UIView *)aView
{
    [aView addSubview:self];
    [self removeGestureRecognizer:self.tap];
    if (self.contentView) {
        
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        [self.alertView addSubview:self.contentView];
        self.alertView.backgroundColor = [UIColor clearColor];
        
        [self.alertView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.bottom.offset(0);
        }];

    }

    
    self.alpha = 0;
    
    self.alertView.transform = CGAffineTransformIdentity;
    
    self.alertView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT-172);
    
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         self.alpha = 1;
                         self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
                         
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
                         self.alertView.transform = CGAffineTransformMakeTranslation(0,SCREEN_HEIGHT-172);

                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                     }];
}


#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.alertView]) {
        return NO;
    }
    
    return YES;
}


#pragma mark - initSubviews

- (void)initSubviews
{
    self.frame = SCREEN_BOUNDS;
    self.backgroundColor = [ColorWithHex(@"1f293e") colorWithAlphaComponent:0.6];
    [self addSubview:self.alertView];
    [self addGestureRecognizer:self.tap];
//    [self.alertView addSubview:self.tooBarView];
    [self.tooBarView addSubview:self.closeButton];
    [self.tooBarView addSubview:self.titleLabel];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-100);
        make.top.offset(100);
        
    }];
    
//    [self.tooBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.left.right.offset(0);
//        make.height.mas_equalTo(40);
//
//    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.offset(10);
//        make.top.offset(0);
//        make.height.mas_equalTo(self.tooBarView);
//        make.right.mas_equalTo(-40);
//    }];
//
//
//    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.offset(0);
//        make.right.offset(0);
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(40);
//
//    }];

    
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"navBar_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UIView *)alertView
{
    if (!_alertView) {
        
        _alertView = [[UIView alloc]initWithFrame:CGRectZero];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 4;
    }
    return _alertView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        
        _webView = [[WKWebView alloc]init];
    }

    return _webView;
}

- (UIView *)tooBarView
{
    if (!_tooBarView) {
        
        _tooBarView = [[UIView alloc]init];
        _tooBarView.backgroundColor  = ColorWithHex(@"017bff");
    }
    
    return _tooBarView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=APPFONT(15);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

-(UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        _tap.delegate = self;
    }
    
    return _tap;
}

@end
