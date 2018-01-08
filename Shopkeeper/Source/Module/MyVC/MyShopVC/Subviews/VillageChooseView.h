//
//  VillageChooseView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/25.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VillageChooseViewDelegate <NSObject>

- (void)villageChooseViewDidChooseVillage:(NSString*)village;

@end

@interface VillageChooseView : UIView

@property(nonatomic,weak)id<VillageChooseViewDelegate> delegate;

- (void)reloadData:(NSArray*)dataSource;

@end
