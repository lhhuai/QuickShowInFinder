//
//  QuickShowInFinder.m
//  QuickShowInFinder
//
//  Created by seaphy on 15/12/30.
//  Copyright © 2015年 seaphy. All rights reserved.
//

#import "QuickShowInFinder.h"

@interface QuickShowInFinder()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) NSString *url;

@end

@implementation QuickShowInFinder

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getFileUrlByClickNotification:)
                                                     name:nil
                                                   object:nil];
        
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)notifycation
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"File"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Quick Show In Finder" action:@selector(doMenuAction) keyEquivalent:@"f"];
        [actionMenuItem setKeyEquivalentModifierMask:NSAlternateKeyMask];
        //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    [[NSWorkspace sharedWorkspace] selectFile:self.url inFileViewerRootedAtPath:nil];
}

- (void)getFileUrlByClickNotification:(NSNotification *)notifycation
{
    if ([notifycation.name isEqualToString:@"transition from one file to another"]) {
        NSURL *originURL = [[notifycation.object valueForKey:@"next"] valueForKey:@"documentURL"];
        if (originURL != nil && [originURL absoluteString].length >= 7 ) {
            self.url = [originURL.absoluteString substringFromIndex:7];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
