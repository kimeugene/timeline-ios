//
//  TViewController.h
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import <UIKit/UIKit.h>
#import "TCoreLocationController.h"

@interface TMapViewController : UIViewController <TCoreLocationControllerDelegate>

@property (nonatomic, retain) TCoreLocationController *CLController;

@end
