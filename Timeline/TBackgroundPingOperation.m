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
    requestNumber = 1;
    CLController = [[TCoreLocation alloc] init];
    CLController.delegate = self;
    [CLController.locMgr startUpdatingLocation];
    NSLog(@"TBackgroundPingOperation: main() executed");

    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    [runLoop run];
}

- (void)locationUpdate:(CLLocation *)location {    
    NSLog(@"TBackgroundPingOperation locationUpdate: location.timestamp: %@", location.timestamp);
    NSLog(@"TBackgroundPingOperation locationUpdate: %@", [location description]);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-50-16-36-166.compute-1.amazonaws.com/post"]];
    self.request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval currentTimestamp = [date timeIntervalSince1970];
    
    // Post:
    NSString *postString = [NSString stringWithFormat:@"email=fitz2@timeline.pwn&timestamp=%i&long=%f&lat=%f", abs(currentTimestamp), location.coordinate.longitude, location.coordinate.latitude];
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
    NSLog(@"TBackgroundPingOperation request succeeded. Finished loading.");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"TBackgroundPingOperation request failed. connection:didFailWithError: %@", [error description]);
}

@end
