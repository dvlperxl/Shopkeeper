//
//  KKAlertView.h
//  kakatrip
//
//  Created by CaiMing on 2016/11/25.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKAlertView : NSObject

- (void)showAlertActionViewWithTitle:(NSString *)title actions:(NSArray *)actions;
- (void)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content actions:(NSArray *)actions;
- (void)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content contentTextAlignment:(NSTextAlignment)textAlignment actions:(NSArray *)actions;


+ (instancetype)showAlertActionViewWithTitle:(NSString *)title actions:(NSArray *)actions;
+ (instancetype)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content actions:(NSArray *)actions;
+ (instancetype)showAlertActionViewWithTitle:(NSString *)title content:(NSString*)content contentTextAlignment:(NSTextAlignment)textAlignment actions:(NSArray *)actions;

@end

@interface KKAlertAction : NSObject
@property(nonatomic,copy,readonly)NSString *title;
+(id)alertActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void(^)(KKAlertAction* action))handler;

@end
