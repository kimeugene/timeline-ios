//
//  TViewController.m
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import "TMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface TMapViewController ()
@property (nonatomic, retain) NSOperationQueue *operationQueue;
@end

@implementation TMapViewController
@synthesize CLController;
@synthesize operationQueue;
GMSMapView *mapView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self setTitle:@"Timeline"];
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CLController = [[TCoreLocationController alloc] init];
    CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
}

- (void)locationUpdate:(CLLocation *)location {
    TServerPingOperation *ping = [[TServerPingOperation alloc] init];
    [ping setLatitude:[NSString stringWithFormat:@"%f",location.coordinate.latitude]];
    [ping setLongitude:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];
    [self.operationQueue addOperation:ping];
    
    NSLog(@"locationUpdate: location.timestamp: %@", location.timestamp);
    NSLog(@"locationUpdate: %@", [location description]);
}

- (void)locationError:(NSError *)error {
    NSLog(@"locationError: %@", [error description]);
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.918426
                                                            longitude:-74.223279
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(40.918426,-74.223279);
    options.title = @"Sydney";
    options.snippet = @"Australia";
    [mapView_ addMarkerWithOptions:options];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
