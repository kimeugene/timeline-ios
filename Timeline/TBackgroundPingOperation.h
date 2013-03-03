//
//  TBackgroundPingOperation.h
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import <Foundation/Foundation.h>
#import "TCoreLocation.h"

@interface TBackgroundPingOperation : NSOperation <NSURLConnectionDelegate, TCoreLocationDelegate>
@property (nonatomic, retain) TCoreLocation       *coreLocation;
@property (strong, retain)    NSURLConnection     *connection;
@property (strong, retain)    NSMutableURLRequest *request;
@property                     NSInteger            requestNumber;
@end
