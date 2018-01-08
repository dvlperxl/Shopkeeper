//
//  OrderDetailBottomView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/15.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "OrderDetailBottomView.h"

@interface OrderDetailBottomView ()

@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,strong)UIButton *cancelButton;

@end


@implementation OrderDetailBottomView

+ (instancetype)orderDetailBottomViewWithButtonTitles:(NSArray<NSString*>*)titles
{
    OrderDetailBottomView *aView = [[OrderDetailBottomView alloc]init];
    aView.titles = titles;
    [aView initSubviews];
    return aView;
}
- (void)reloadData:(NSArray<NSString*>*)titles
{
    if (self.saveButton) {
        [self.saveButton removeFromSuperview];
        self.saveButton = nil;
    }
    
    if (self.cancelButton) {
        [self.cancelButton removeFromSuperview];
        self.cancelButton = nil;
    }
    self.titles = titles;
    [self initSubviews];
}

- (void)onButtonAction:(UIButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(orderDetailBottomViewDidSelectBottomButtonIndex:)])
    {
        [self.delegate orderDetailBottomViewDidSelectBottomButtonIndex:btn.tag];
    }
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    
    if (self.titles.count == 2)
    {
        UIButton *saveButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setBackgroundImage:Image(@"popup_btn") forState:UIControlStateNormal];
        saveButton.tag = 1;
        
        [saveButton setTitle:self.titles.lastObject forState:UIControlStateNormal];
        [saveButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        saveButton.titleLabel.font = APPFONT(18);
        [saveButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
        _saveButton = saveButton;
        [self addSubview:saveButton];
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(3);
            make.right.offset(-20);
            make.width.mas_equalTo(162);
            make.height.mas_equalTo(57);
            
        }];
        
        UIButton *cancelButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.tag = 0;
        
        [cancelButton setTitle:self.titles.firstObject forState:UIControlStateNormal];
        [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        cancelButton.titleLabel.font = APPFONT(18);
        [cancelButton setTitleColor:ColorWithHex(@"#333333") forState:UIControlStateNormal];
        
        [self addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(3);
            make.left.offset(40);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(57);
            
        }];
        _cancelButton = cancelButton;
        
    }else
    {
        UIButton *saveButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [saveButton addTarget:self action:@selector(onButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [saveButton setBackgroundImage:Image(@"signup_btn") forState:UIControlStateNormal];
        saveButton.tag = 0;
        NSString *title = self.titles.firstObject;
        [saveButton setTitle:title forState:UIControlStateNormal];
        [saveButton setTitleEdgeInsets:UIEdgeInsetsMake(-6, 0, 0, 0)];
        saveButton.titleLabel.font = APPFONT(18);
        [saveButton setTitleColor:ColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
        _saveButton = saveButton;
        [self addSubview:saveButton];
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(3);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(57);
            
        }];
    }
}


@end
