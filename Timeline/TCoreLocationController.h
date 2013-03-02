//
//  TCoreLocationController.h
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TCoreLocationControllerDelegate
@required
- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
- (void)locationError:(NSError *)error; // Any errors are sent here
@end

@interface TCoreLocationController : NSObject <CLLocationManagerDelegate> 
@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, assign) id delegate;
@end
