//
//  TBackgroundPingOperation.h
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import <Foundation/Foundation.h>

@interface TBackgroundPingOperation : NSOperation <NSURLConnectionDelegate>
@property (strong, retain) NSURLConnection *connection;
@property (strong, retain) NSMutableURLRequest *request;
@property (strong, retain) NSTimer *pingTimer;
@property NSInteger requestNumber;
@end
