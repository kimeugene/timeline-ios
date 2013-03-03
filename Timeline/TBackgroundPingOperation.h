//
//  TBackgroundPingOperation.h
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import <Foundation/Foundation.h>
#import "TCoreLocationController.h"

@interface TBackgroundPingOperation : NSOperation <NSURLConnectionDelegate, TCoreLocationControllerDelegate>
@property (nonatomic, retain) TCoreLocationController *CLController;
@property (strong, retain) NSURLConnection *connection;
@property (strong, retain) NSMutableURLRequest *request;
@property NSInteger requestNumber;
@property (strong, retain) NSTimer *pingTimer;
@end
