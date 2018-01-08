//
//  MemberDetailCropCell.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/24.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberDetailCropCell : UITableViewCell


@end

@interface MemberDetailCropView : UIView

@end

@interface MemberDetailCropViewModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;

@end
