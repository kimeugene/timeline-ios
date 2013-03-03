//
//  TBackgroundPingOperation.m
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import "TBackgroundPingOperation.h"

@implementation TBackgroundPingOperation
@synthesize connection;
@synthesize request;
@synthesize pingTimer;
@synthesize requestNumber;

- (void)main {
    requestNumber = 1;
    pingTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                 target:self
                                               selector:@selector(send)
                                               userInfo:nil
                                                repeats:YES];
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:pingTimer forMode:NSRunLoopCommonModes];
    [runLoop run];
    NSLog(@"TBackgroundPingOperation: main() executed");
}

- (void)send {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.fastestvideodownloader.com/timeline/TBackgroundPingOperation.h?requestNumber=%i", requestNumber]];
    self.request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval currentTimestamp = [date timeIntervalSince1970];
    
    // Post:
    NSString *postString = [NSString stringWithFormat:@"email=fitz@timeline.pwn&timestamp=%i&long=%@&lat=%@", abs(currentTimestamp), @"50", @"40"];
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



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError: %@", [error description]);
}

@end
