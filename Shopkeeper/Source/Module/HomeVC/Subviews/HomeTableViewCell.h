//
//  HomeTableViewCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@end

@interface HomeTableViewCellModel : NSObject

@property(nonatomic,copy)NSString *iconName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *dateTime;
@property(nonatomic,copy)NSNumber *redPointCount;

@end

