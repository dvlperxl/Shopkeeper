//
//  AddGoodsHeaderView.h
//  Shopkeeper
//
//  Created by xl on 2017/11/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddGoodsHeaderView;

@protocol AddGoodsHeaderViewDelegate <NSObject>

- (void)tapHeader:(AddGoodsHeaderView *)header;
@end

@interface AddGoodsHeaderView : UITableViewHeaderFooterView

@property (nonatomic,weak) id<AddGoodsHeaderViewDelegate> delegate;
@end


@interface AddGoodsHeaderViewModel : NSObject

@property (nonatomic,copy) NSString *headerTitle;
@property (nonatomic,strong) UIImage *openStatusImage;
@property (nonatomic,assign) BOOL open;
@end
