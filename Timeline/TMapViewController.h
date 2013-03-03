//
//  TViewController.h
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

#import "TCoreLocation.h"
#import "TBackgroundPingOperation.h"
#import "TGetTimelineOperation.h"

@interface TMapViewController : UIViewController <TGetTimelineOperationDelegate>

- (void)sendGetTimelineRequest;
- (void)updateTimeline:(NSArray*)listOfCoordinates;

@end
