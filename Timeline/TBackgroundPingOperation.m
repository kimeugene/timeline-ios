//
//  TBackgroundPingOperation.m
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import "TBackgroundPingOperation.h"

@implementation TBackgroundPingOperation
@synthesize CLController;
@synthesize connection;
@synthesize request;
@synthesize requestNumber;
@synthesize pingTimer;

- (void)main {
    pingTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                 target:self
                                               selector:@selector(send)
                                               userInfo:nil
                                                repeats:YES];
    
    requestNumber = 1;
    CLController = [[TCoreLocationController alloc] init];
    CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
    NSLog(@"TBackgroundPingOperation: main() executed");

    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    //    [runLoop addTimer:pingTimer forMode:NSRunLoopCommonModes];
    [runLoop run];
}

- (void)send {
    NSLog(@"send!");
}

- (void)locationUpdate:(CLLocation *)location {    
    NSLog(@"TBackgroundPingOperation locationUpdate: location.timestamp: %@", location.timestamp);
    NSLog(@"TBackgroundPingOperation locationUpdate: %@", [location description]);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.fastestvideodownloader.com/timeline/TBackgroundPingOperation.h?requestNumber=%i", requestNumber]];
    self.request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval currentTimestamp = [date timeIntervalSince1970];
    
    // Post:
    NSString *postString = [NSString stringWithFormat:@"email=fitz@timeline.pwn&timestamp=%i&long=%f&lat=%f", abs(currentTimestamp), location.coordinate.longitude, location.coordinate.latitude];
    [self.request setHTTPMethod:@"POST"];
    [self.request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [self.request setValue:[NSString stringWithFormat:@"%d", [postString length]] forHTTPHeaderField:@"Content-Length"];
    [self.request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Get
    // [self.request setHTTPMethod:@"GET"];
    
    connection = [[NSURLConnection alloc] initWithRequest:self.request
                                                 delegate:self
                                         startImmediately:YES];
    requestNumber++;
}

- (void)locationError:(NSError *)error {
    NSLog(@"locationError: %@", [error description]);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError: %@", [error description]);
}

@end
