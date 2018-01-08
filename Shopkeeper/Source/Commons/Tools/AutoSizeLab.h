//
//  AutoSizeLab.h
//  NewEBPP
//
//  Created by Jack on 14-12-9.
//  Copyright (c) 2014年 SHFFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoSizeLab : UILabel

-(CGSize)autoSizeLabNoLineSpacing:(CGSize)size  withFont:(UIFont*)font withSting:(NSString*)string;

@end
