//
//  TNSOperation.h
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import <Foundation/Foundation.h>
#import "TConfig.h"

@interface TServerPingOperation : NSOperation <NSURLConnectionDelegate>
@property (strong, retain) NSURLConnection *connection;
@property (strong, retain) NSMutableURLRequest *request;
@property (strong, retain) NSString *latitude;
@property (strong, retain) NSString *longitude;
@end
