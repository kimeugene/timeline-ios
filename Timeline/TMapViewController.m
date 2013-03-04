//
//  TViewController.m
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import "TMapViewController.h"

@interface TMapViewController ()
@property (strong, nonatomic) NSOperationQueue *m_operationQueue;
@end

@implementation TMapViewController
GMSMapView *mapView_;
@synthesize m_operationQueue;
@synthesize m_updatePinsFromServer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self setTitle:@"Timeline"];
        m_operationQueue = [[NSOperationQueue alloc] init];
        [self sendGetTimelineRequest];
        m_updatePinsFromServer = [NSTimer scheduledTimerWithTimeInterval:5
                                                                  target:self
                                                                selector:@selector(sendGetTimelineRequest)
                                                                userInfo:nil
                                                                 repeats:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.918426
                                                            longitude:-74.223279
                                                                 zoom:14];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
}

- (void)sendGetTimelineRequest
{
    [mapView_ clear];
    TGetTimelineOperation *getTimelineOperation = [[TGetTimelineOperation alloc] init];
    [getTimelineOperation setDate:@"20130303"];
    [getTimelineOperation setDelegate:self];
    [self.m_operationQueue addOperation:getTimelineOperation];
    NSLog(@"sendGetTimelineRequest finished()");
}

- (void)timelineResponse:(NSArray *)listOfCoordinates
{
    NSLog(@"Received a timeline response with %i locations", [listOfCoordinates count]);
    [self performSelectorOnMainThread:@selector(updateTimeline:) withObject:listOfCoordinates waitUntilDone:NO];
}

- (void)updateTimeline:(NSArray *)listOfCoordinates
{
    for(int i=0; i<[listOfCoordinates count]; i++) {
        GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
        CLLocationDegrees latitude  = [[[listOfCoordinates objectAtIndex:i] objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude = [[[listOfCoordinates objectAtIndex:i] objectAtIndex:1] doubleValue];
        options.position = CLLocationCoordinate2DMake(latitude, longitude);
        [mapView_ addMarkerWithOptions:options];
    }
    NSLog(@"Updated timeline");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
