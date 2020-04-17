#import "FlutterDropdownMenuPlugin.h"
#import <flutter_dropdown_menu/flutter_dropdown_menu-Swift.h>

@implementation FlutterDropdownMenuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDropdownMenuPlugin registerWithRegistrar:registrar];
}
@end
