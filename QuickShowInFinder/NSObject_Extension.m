//
//  NSObject_Extension.m
//  QuickShowInFinder
//
//  Created by seaphy on 15/12/30.
//  Copyright © 2015年 seaphy. All rights reserved.
//


#import "NSObject_Extension.h"
#import "QuickShowInFinder.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[QuickShowInFinder alloc] initWithBundle:plugin];
        });
    }
}
@end
