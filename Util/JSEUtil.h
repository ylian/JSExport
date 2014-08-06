//
//  JSEUtil.h
//  JSExport
//
//  Created by Yaogang Lian on 8/6/14.
//  Copyright (c) 2014 HappenApps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSEUtilExports <JSExport>

+ (void)openURL:(NSString *)url;

@end

@interface JSEUtil : NSObject <JSEUtilExports>
@end
