//
//  SMSTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2018/1/5.
//  Copyright © 2018年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMSTableViewCellDelegate<NSObject>

- (void)SMSTableViewCellDidSelectMenuIndex:(NSInteger)index;

@end

@interface SMSTableViewCell : UITableViewCell

@property(nonatomic,weak)id<SMSTableViewCellDelegate> delegate;

@end
