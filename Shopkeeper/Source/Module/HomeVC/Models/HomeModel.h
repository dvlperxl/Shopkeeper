//
//  HomeModel.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/27.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

+(KKTableViewModel*)tableViewModel:(NSNumber*)unreadCount;

@end
