//
//  TNSOperation.m
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import "TServerPingOperation.h"

@implementation TServerPingOperation
@synthesize connection;

- (void)main {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-50-16-36-166.compute-1.amazonaws.com/post"]];
    self.request = [[NSMutableURLRequest alloc] initWithURL:url];
    [self.request setHTTPMethod:@"POST"];
    [self.request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval howRecent = [date timeIntervalSince1970];
    NSString *postString = [NSString stringWithFormat:@"email=fitz@timeline.pwn&timestamp=%f&long=%@&lat=%@", howRecent,
                            self.longitude, self.latitude];
    [self.request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

    connection = [[NSURLConnection alloc] initWithRequest:self.request
                                                 delegate:self
                                         startImmediately:YES];
    
    NSLog(@"TServerPingOperation: main() executed");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading!");
}

@end
