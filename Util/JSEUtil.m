//
//  JSEUtil.m
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "JSEUtil.h"

@implementation JSEUtil

+ (void)openURL:(NSString *)url
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
