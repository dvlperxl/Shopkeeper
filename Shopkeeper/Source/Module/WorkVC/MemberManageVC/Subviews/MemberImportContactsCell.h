//
//  MemberImportContactsCell.h
//  Dev
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberImportContactsCell : UITableViewCell

@end

// 定义协议，处理选中状态
@protocol MemberImportContactsCellModelManager <NSObject>

@property (nonatomic,strong,readonly) NSMutableArray *selctedItems;
@end

@interface MemberImportContactsCellModel : NSObject

@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL enabled;
@property (nonatomic,copy) NSString *contactName;
@property (nonatomic,copy) NSString *contactPhone;
@property (nonatomic,strong,readonly) UIImage *contactStatusImage;
@property (nonatomic,copy,readonly) NSAttributedString *contactStatusStr;
@property (nonatomic,strong,readonly) UIColor *contactStatusBgColor;

@property (nonatomic,weak) id<MemberImportContactsCellModelManager> manager;
@end
