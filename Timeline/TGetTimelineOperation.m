//
//  TGetTimelineOperation.m
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import "TGetTimelineOperation.h"

@implementation TGetTimelineOperation
@synthesize m_date;
@synthesize m_delegate;
@synthesize m_connection;
@synthesize m_request;
@synthesize m_responseData;

- (void)setDate:(NSString *)date
{
    m_date = date;
}

- (void)setDelegate:(id)delegate
{
    m_delegate = delegate;
}

- (void)main
{
    NSLog(@"TGetTimelineOperation: main() starting execution");
    m_responseData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-50-16-36-166.compute-1.amazonaws.com/get/fitz4@timeline.pwn/2013-03-03"]];
    m_request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval currentTimestamp = [date timeIntervalSince1970];
    
    [m_request setHTTPMethod:@"GET"];
    m_connection = [[NSURLConnection alloc] initWithRequest:m_request
                                                   delegate:self
                                           startImmediately:YES];
    NSLog(@"TGetTimelineOperation main() execution  finished");
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    [runLoop run];
}

- (void)unload
{
    NSLog(@"TGetTimelineOperation unloading");
    [self cancel];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"TGetTimelineOperation connection:didFailWithError %@", [error description]);
    [self unload];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"TGetTimelineOperation connectionDidFinishLoading. Size: %i", [m_responseData length]);
    NSArray *listOfCoordinates = [NSJSONSerialization JSONObjectWithData:m_responseData options:kNilOptions error:nil];
    NSLog(@"number of coordinate pairs: %i", [listOfCoordinates count]);
    [m_delegate timelineResponse:listOfCoordinates];
    [self unload];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_responseData appendData:data];
}

@end
