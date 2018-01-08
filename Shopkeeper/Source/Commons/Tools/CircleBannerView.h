//
//  BannerView.h
//  kakatrip
//
//  Created by CaiMing on 2016/12/5.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircleBannerViewDelegate <NSObject>

- (void)circleBannerView:(UIView *)aView didSelectIndex:(NSInteger )index;

@end

@interface CircleBannerView : UIView

@property(nonatomic,weak)id<CircleBannerViewDelegate> delegate;

- (void)reloadData:(NSArray*)urls selectIndex:(int)index;

- (void)startTimer;
- (void)stopTimer;

@end
