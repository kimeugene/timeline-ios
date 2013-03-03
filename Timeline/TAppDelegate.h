//
//  TAppDelegate.h
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

#import "TNavigationController.h"
#import "TBackgroundPingOperation.h"

@interface TAppDelegate : UIResponder <UIApplicationDelegate>

@property UIBackgroundTaskIdentifier bgTask;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TNavigationController *navigationController;
@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end
