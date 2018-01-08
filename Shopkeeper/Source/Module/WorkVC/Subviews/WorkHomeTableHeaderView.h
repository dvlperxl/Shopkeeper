//
//  WorkHomeTableHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkHomeTableHeaderViewDelegate <NSObject>

- (void)workHomeTableHeaderViewDidSelectChooseStoreButton;

@end

@interface WorkHomeTableHeaderView : UIView

@property(nonatomic,weak)id<WorkHomeTableHeaderViewDelegate> delegate;

- (void)reloadData:(NSString*)title showChooseButton:(BOOL)show;

@end

