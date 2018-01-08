//
//  NSURL+Scheme.m
//  kakatrip
//
//  Created by CaiMing on 2017/2/14.
//  Copyright © 2017年 kakatrip. All rights reserved.
//

#import "NSURL+Scheme.h"

@implementation NSURL (Scheme)

- (NSDictionary*)kakatripSchemeParam
{
    if ([self.scheme isEqualToString:@"kakatrip"])
    {
        NSURLComponents *urlC = [NSURLComponents componentsWithURL:self
                                           resolvingAgainstBaseURL:YES];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        
        for (NSURLQueryItem *item in urlC.queryItems)
        {
            [param setObject:item.value forKey:item.name];
        }
        if (self.host) {
            [param setObject:self.host forKey:@"pageName"];

        }
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:@"showNativePage" forKey:@"action"];
        [data setObject:param    forKey:@"param"];
        return data.copy;
        
    }
    return nil;
}

@end
