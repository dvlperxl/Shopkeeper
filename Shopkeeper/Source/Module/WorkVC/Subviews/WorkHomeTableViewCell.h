//
//  WorkHomeTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/20.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkHomeTableViewCell;

@protocol WorkHomeTableViewCellDelegate <NSObject>

- (void)workHomeTableViewCell:(WorkHomeTableViewCell*)aCell didSelectMenuWithActionName:(NSString*)actionName;

@end

@interface WorkHomeTableViewCell : UITableViewCell

@property(nonatomic,weak)id<WorkHomeTableViewCellDelegate> delegate;

- (void)reloadData:(NSArray*)menus;


@end

@interface WorkHomeItemView : UIView


@end


@interface WorkHomeItemViewModel : NSObject

@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *actionName;
@property(nonatomic,assign)BOOL showTips;

@end
