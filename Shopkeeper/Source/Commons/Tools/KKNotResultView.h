//
//  KKNotResultView.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/12/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKNotResultView : UIView

+ (instancetype)noResultViewWithImageName:(NSString *)imageName;

- (void)reloadDataWithImageName:(NSString*)imageName;
- (void)reloadDataWithImageName:(NSString*)imageName title:(NSString *)title desc:(NSString*)desc;


@end
