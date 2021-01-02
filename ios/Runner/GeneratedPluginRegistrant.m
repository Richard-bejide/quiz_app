//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<fileaudioplayer/FileaudioplayerPlugin.h>)
#import <fileaudioplayer/FileaudioplayerPlugin.h>
#else
@import fileaudioplayer;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FileaudioplayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FileaudioplayerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
