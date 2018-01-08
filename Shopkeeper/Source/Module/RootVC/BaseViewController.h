//
//  BaseViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic, strong)UIView *navView;
@property(nonatomic, strong)NSString *leftButtonImage;//default arrow_back
@property(nonatomic, strong)NSString *leftButtonTitle;//default arrow_back
@property(nonatomic, strong)UIButton *backBtn;

@property(nonatomic, assign)CGFloat navBarHeight;
@property(nonatomic, assign)BOOL present;

@property(nonatomic, copy)NSString *backClassName;
@property(nonatomic, copy)NSDictionary *callBack;

- (void)statusBarStyleDefault;
- (void)statusBarStyleLightContent;
- (void)onBackBtnAction;
- (void)setBackBtnTitle:(NSString*)title;

- (NSString*)pathAppendBaseURL:(NSString*)path;
- (NSString*)urlAppendBaseParam:(NSString*)url;
- (void)setScrollViewInsets:(NSArray<UIScrollView*>*)scrollViewList;

@end
