//
//  UpdateVersionView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateVersionViewDelegate <NSObject>

- (void)updateVersionViewDidDisAppear;

@end
@class UpdateVersionViewModel;

@interface UpdateVersionView : UIView

@property(nonatomic,weak)id<UpdateVersionViewDelegate> delegate;

- (void)reloadData:(UpdateVersionViewModel*)model;

@end


@interface UpdateVersionViewModel :NSObject

@property(nonatomic,copy)NSString *version;
@property(nonatomic,assign)BOOL force;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *url;

@end



