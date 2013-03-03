//
//  TCoreLocationController.m
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import "TCoreLocationController.h"

@implementation TCoreLocationController
@synthesize locMgr;
@synthesize delegate;

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locMgr = [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
        [self.locMgr setDistanceFilter:2];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    if([self.delegate conformsToProtocol:@protocol(TCoreLocationControllerDelegate)]) {
        NSDate *eventDate = newLocation.timestamp;
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        if (abs(howRecent) > 15.0) {
        //    return;
        }
        
        [self.delegate locationUpdate:newLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
        if([self.delegate conformsToProtocol:@protocol(TCoreLocationControllerDelegate)]) {
            [self.delegate locationError:error];
        }
}

@end
