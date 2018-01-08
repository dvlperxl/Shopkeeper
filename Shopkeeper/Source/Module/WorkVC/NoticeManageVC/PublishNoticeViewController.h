//
//  PublishNoticeViewController.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishNoticeViewController : BaseViewController

@property(nonatomic,strong)NSString *storeId;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *mainBody;
@property(nonatomic,copy)NSString *contacts;

@end
