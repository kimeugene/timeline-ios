//
//  TNavigationControllerViewController.m
//  Timeline
//
//  Created by Fitz on 3/2/13.
//
//

#import "TNavigationController.h"

@interface TNavigationController ()
@end

@implementation TNavigationController
@synthesize mapViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mapViewController = [[TMapViewController alloc] init];
        [self pushViewController:self.mapViewController animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
