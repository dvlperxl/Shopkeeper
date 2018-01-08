//
//  NoticeListModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeListModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *releaseTime;
@property(nonatomic,strong)NSNumber *reSend;
@property(nonatomic,copy)NSString *mainBody;

+ (KKTableViewModel *)tableViewModel:(NSArray*)noticeList;

@end
