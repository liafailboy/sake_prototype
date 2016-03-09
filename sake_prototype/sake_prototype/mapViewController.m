//
//  mapViewController.m
//  sake_prototype
//
//  Created by Shotaro Watanabe on 2/25/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import "mapViewController.h"

@import GoogleMaps;

@interface mapViewController ()

@end

@implementation mapViewController {
    GMSMapView *mapView_;
}

#define numberOfSake 57
#define navigationBarY 65

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    defaults = [NSUserDefaults standardUserDefaults];
    arrayOfSakeDictionary = [defaults mutableArrayValueForKey:@"arrayOfSakeDictionary"];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    // set the map view
    [self setUpGoogleMap];

    // set the navigation bar with UIView
    [self setUpNaviationBar];
    
    // set the button to change the view
    [self setUpViewChangeButton];
}

- (void)setUpNaviationBar {
    
    // initialize navigation bar on the main screen
    UIView *statusBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 375, 20)];
    
    // set the background color of navigation bar to light gray
    statusBar.backgroundColor = [UIColor whiteColor];
    
    // add navigation bar into main screen
    [self.view addSubview:statusBar];
    
    // initialize navigation bar on the main screen
    UIView *navigationBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 20, 375, 45)];
    
    // set the background color of navigation bar to light gray
    navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    // add navigation bar into main screen
    [self.view addSubview:navigationBar];
}

- (void)setUpViewChangeButton {
    
    // intitalize image and button
    UIImage *buttonImage = [UIImage imageNamed:@"change_to_grid.png"];
    
    // initialize button
    UIButton *buttonForViewChange = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // set the location and the size of the button
    [buttonForViewChange setFrame:CGRectMake(328, 27, 30, 30)];
    
    // set the image of buttons
    [buttonForViewChange setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // call action method when button is pushed
    [buttonForViewChange addTarget:self action:@selector(viewChangeButtonPushed:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // add the buttons to the scrollview
    [self.view addSubview:buttonForViewChange];
}

- (void)setUpGoogleMap {
    // Create a GMSCameraPosition that tells the map to display
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.894686
                                                            longitude:137.583892
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    self.view = mapView_;
    
    for (int i = 0; i < numberOfSake; i++) {
        
         //load and set the x, y of button pin
        NSDictionary *sakeDictionary = [arrayOfSakeDictionary objectAtIndex:i];
        
        NSString *sakeName = [sakeDictionary objectForKey:@"NAME"];
        NSString *company = [sakeDictionary objectForKey:@"COMPANY"];
        NSString *prefecture = [sakeDictionary objectForKey:@"PREFECTURE"];
        double latitude = [[sakeDictionary objectForKey:@"LATITUDE"] doubleValue];
        double longitude = [[sakeDictionary objectForKey:@"LONGITUTDE"] doubleValue];
        
        // initialize GMS marker
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(latitude, longitude);
        marker.title = sakeName;
        marker.snippet = [[company stringByAppendingString:@", "] stringByAppendingString:prefecture];
        marker.flat = YES;
        marker.userData = [NSString stringWithFormat:@"%d", i];
        marker.map = mapView_;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    [self viewChangeToDetailWithID:[marker.userData intValue]];
}

//- (void)setUpPinButtons {
//    
//    // initialize new scrollview to enable scrolling map of Japan
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBarY, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY)];
//    
//    scrollView.minimumZoomScale = 0.125;
//    scrollView.maximumZoomScale = 1.0;
//    
//    scrollView.bounces = NO;
//    scrollView.bouncesZoom = NO;
//    
//    // set the delegate of scrollview to self
//    scrollView.delegate = self;
//    
//    // initialize new UIImageview for map of Japan
//    mapOfJapan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_japan.jpg"]];
//    int xWidth = self.view.bounds.size.height * 8;
//    NSLog(@"%d", xWidth);
//    scrollView.contentSize = CGSizeMake(xWidth, xWidth);
//    mapOfJapan.frame = CGRectMake(0, 0, xWidth, xWidth);
//    
//    // add mapOfJapan on scrollView
//    [scrollView addSubview:mapOfJapan];
//    
//    // set all buttons across map
//    [self setUpPinButtons];
//    
//    // add scrollview to the main view
//    [self.view addSubview:scrollView];
//    
//    scrollView.zoomScale = 0.125;
//    scrollView.contentOffset = CGPointMake(scrollView.contentSize.width / 2 - self.view.bounds.size.height / 4, scrollView.contentSize.height / 2 - self.view.bounds.size.height / 2);
//    
//    // initialize buttons (pins) across map of Japan
//    UIImage *pinImage = [UIImage imageNamed:@"pin.png"];
//    
//    // show all buttons across Japan
//    for (int i = 0; i < numberOfSake; i++) {
//        
//        UIButton *buttonPin = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        // load and set the x, y of button pin
//        NSDictionary *sakeDictionary = [arrayOfSakeDictionary objectAtIndex:i];
//        
//        double latitude = [[sakeDictionary objectForKey:@"LATITUDE"] doubleValue];
//        double longitude = [[sakeDictionary objectForKey:@"LONGITUTDE"] doubleValue];
//        
//        // set x and y coordinates of buttons and width and height
//        [buttonPin setFrame:CGRectMake(0, 0, 160, 160)];
//        
//        double buttonX = (46.437756321 - latitude)/ 0.003420295974;
//        double buttonY = (longitude - 125.8162830114) / 0.004490777401;
//        
//        NSLog(@"%f, %f", buttonX, buttonY);
//        
//        buttonPin.center = CGPointMake(buttonX, buttonY);
//        
//        // set the image of buttons
//        [buttonPin setImage:pinImage forState:UIControlStateNormal];
//        
//        // set the tag number for each button
//        buttonPin.tag = i;
//        
//        // call action method when button is pushed
//        [buttonPin addTarget:self action:@selector(pinButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
//        
//        // add the buttons to the scrollview
//        [mapOfJapan addSubview:buttonPin];
//    }
//}

//- (void)pinButtonPushed:(UIButton*) button {
//    
//}
//
//// return the object to be zoomed in and out
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return mapOfJapan;
//}

- (void)viewChangeToDetailWithID:(int)sakeID {
    
    [defaults setInteger:sakeID forKey:@"sakeID"];
    
    UIViewController *dVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:dVC animated:NO completion:nil];
}

- (void)viewChangeButtonPushed:(UIButton *) button {
    
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
