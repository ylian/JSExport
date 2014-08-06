//
//  JSEHttpRequest.m
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import "JSEHttpRequest.h"

@implementation JSEHttpRequest

+ (JSEHttpRequest *)create
{
    return [[JSEHttpRequest alloc] init];
}

- (void)get:(NSString *)url then:(JSValue *)callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10.f];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [callback callWithArguments:@[response, @YES]];
        }
    }];
}

@end
