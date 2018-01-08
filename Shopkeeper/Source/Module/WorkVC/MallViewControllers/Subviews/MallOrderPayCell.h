//
//  MallOrderPayCell.h
//  Shopkeeper
//
//  Created by xl on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallOrderPayCell : UITableViewCell

@end


@interface MallOrderPayCellModel : NSObject

@property (nonatomic,strong) UIImage *payIcon;
@property (nonatomic,copy) NSAttributedString *content;
@property (nonatomic,strong) UIImage *selectedImage;
@end
