//
//  JSEHttpRequest.h
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class JSEHttpRequest;

@protocol JSEHttpRequestExports <JSExport>

+ (JSEHttpRequest *)create;

JSExportAs(get,
- (void)get:(NSString *)url then:(JSValue *)callback
);

@end

@interface JSEHttpRequest : NSObject <JSEHttpRequestExports>
@end
