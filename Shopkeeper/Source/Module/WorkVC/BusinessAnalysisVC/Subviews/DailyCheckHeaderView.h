//
//  DailyCheckHeaderView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/28.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DailyCheckHeaderViewDelgegate <NSObject>

- (void)dailyCheckHeaderViewDidSelectChooseDateTime;

@end

@interface DailyCheckHeaderView : UITableViewHeaderFooterView

@property(nonatomic, weak)id<DailyCheckHeaderViewDelgegate> delegate;

- (void)reloadData:(NSString*)dateTime;

@end
