#import "SBLAppDelegate.h"
#import "SBLViewController.h"

@implementation SBLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[SBLViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
