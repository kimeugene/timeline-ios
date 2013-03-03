//
//  TGetTimelineOperation.h
//  Timeline
//
//  Created by Fitz on 3/3/13.
//
//

#import <Foundation/Foundation.h>

@protocol TGetTimelineOperationDelegate
@required
- (void)timelineResponse:(NSArray*)listOfCoordinates; // Our timeline response is sent here
@end

@interface TGetTimelineOperation : NSOperation <NSURLConnectionDelegate>

- (void)setDate:(NSString*)date;
- (void)setDelegate:(id)delegate;

@property (strong, nonatomic) id               m_delegate;
@property (strong, nonatomic) NSString        *m_date;
@property (strong, nonatomic) NSURLConnection *m_connection;
@property (strong, nonatomic) NSMutableURLRequest *m_request;
@property (strong, nonatomic) NSMutableData       *m_responseData;

@end
