//
//  GoodsDetailNormalCell.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailNormalCell : UITableViewCell

@end


@interface GoodsDetailNormalCellModel : NSObject

@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,copy) NSString *goodsContent;
@property (nonatomic,strong) NSArray *parameterNames;
@end
