//
//  KKToast.h
//  Common
//
//  Toast

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KKToast : NSObject

/**
 *	@brief	弹出KKToast方法。
 */
- (void)show;

/**
 *	@brief	构造一个MJToast对象
 *
 *	@param 	text 	需要显示的字符串
 *
 *	@return	返回的MJToast对象
 */
+ (KKToast *)makeToast:(NSString *)text;

@end
