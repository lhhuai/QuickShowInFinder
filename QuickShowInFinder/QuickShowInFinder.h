//
//  QuickShowInFinder.h
//  QuickShowInFinder
//
//  Created by seaphy on 15/12/30.
//  Copyright © 2015年 seaphy. All rights reserved.
//

#import <AppKit/AppKit.h>

@class QuickShowInFinder;

static QuickShowInFinder *sharedPlugin;

@interface QuickShowInFinder : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end