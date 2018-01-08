//
//  PlaceholderHeaderFooterView.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/17.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "PlaceholderHeaderFooterView.h"

@implementation PlaceholderHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];

    }
    
    return self;
}

@end
