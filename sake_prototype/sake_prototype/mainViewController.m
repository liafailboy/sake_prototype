//
//  ViewController.m
//  sake_prototype
//
//  Created by Shotaro Watanabe on 2/20/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import "mainViewController.h"

@import GoogleMaps;

@interface mainViewController ()

@end

@implementation mainViewController {
    GMSMapView *mapView_;
}

#define navigationBarY 65

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // load JSON file from local file
    [self loadJSON];
    [self setUpUI];
}

- (void)loadJSON {
    
    // initialize mutable array for sake dictionary
    arrayOfSakeDictionary = [NSMutableArray array];
    
    // set the file path of sake list with JSON format
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"sake_list" ofType:@"json"];
    
    // get the data from JSON to String format
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    // Parse JSON file with file contents
    NSArray *arrayForJSON = (NSArray *) [NSJSONSerialization
                                         JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                         options:0 error:NULL];
    
    for (int i = 0; i < [arrayForJSON count]; i++) {
        // each dictionary have all information of one sake
        // put dictionary to mutable array
        sakeDictionary = [arrayForJSON objectAtIndex:i];
        [arrayOfSakeDictionary addObject:sakeDictionary];
    }
    
    // put the data of JSON file in to NSUserDefaults
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:arrayOfSakeDictionary forKey:@"arrayOfSakeDictionary"];
}

- (void)setUpUI {
    
    // initialize page based view horizontally
    [self setUpBottomScrollView];
    
    // initialize new scrollview to enable scrolling buttons
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY)];
    
    buttonX = self.view.bounds.size.width / 3;
    buttonY = buttonX;

    // initialize userdefaults for global variables
//    defaults = [NSUserDefaults standardUserDefaults];
//    arrayOfSakeDictionary = [defaults mutableArrayValueForKey:@"arrayOfSakeDictionary"];
//
    
    // set the UIView for navigation bar
    [self setUpNavigationBar];
    
    // set the view change button
    [self setUpViewChangeButton];
    
    // set the grid buttons
    [self setUpGridButtons];
    
    // set the scroll view
    [self setUpScrollView];
    
    // set the map view
    [self setUpGoogleMap];
}

- (void)setUpGoogleMap {
    // Create a GMSCameraPosition that tells the map to display
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.894686
                                                            longitude:137.583892
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY) camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;
    [bottomScrollView addSubview:mapView_];
    
    for (int i = 0; i < [arrayOfSakeDictionary count]; i++) {
        
        sakeDictionary = [arrayOfSakeDictionary objectAtIndex:i];
        
        //load and set the x, y of button pin        
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
    // called when user tapped marker on the map
    [self viewChangeToDetailWithID:[marker.userData intValue]];
}

- (void)setUpBottomScrollView {
    
    // initialize scroll view for horizontal move
    bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBarY, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY)];
    
    bottomScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height - navigationBarY);
    
    bottomScrollView.pagingEnabled = YES;
    
    bottomScrollView.delegate = self;
    
    bottomScrollView.bounces = NO;
    
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:bottomScrollView];
}

- (void)setUpNavigationBar {
    
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
    UIImage *buttonImage = [UIImage imageNamed:@"change_to_map.png"];
    
    // initialize button
    buttonForViewChange = [UIButton buttonWithType:UIButtonTypeCustom];
    
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

- (void)setUpGridButtons {
    
    // produce buttons of sake with corresponding image from the library
    for (int i = 0; i < [arrayOfSakeDictionary count]; i++) {
        
        // intitalize image and button
        // *************LATER ON CHANGE HERE***************
        // [NSString stringWithFormat:@"button_sake_%d", i] stringByAppendingString:@".png"]]
        // *************LATER ON CHANGE HERE***************
        UIImage *buttonImage = [UIImage imageNamed:@"button_sake_01.png"];
        
        UIButton *buttonForSake = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // set x and y coordinates of buttons and width and height
        [buttonForSake setFrame:CGRectMake(buttonX * (i % 3), buttonY * (i / 3), buttonX, buttonY)];
        
        // set the image of buttons
        [buttonForSake setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        // set the title of buttons
        [buttonForSake setTitle:[[arrayOfSakeDictionary objectAtIndex:i] objectForKey:@"NAME"]
                       forState:UIControlStateNormal];
        
        // set the title color of buttons
        [buttonForSake setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // set the tag number for each button
        buttonForSake.tag = i;
        
        // call action method when button is pushed
        [buttonForSake addTarget:self action:@selector(sakeButtonPushed:)
                forControlEvents:UIControlEventTouchUpInside];
        
        // add the buttons to the scrollview
        [scrollView addSubview:buttonForSake];
    }
}

- (void)setUpScrollView {
    
    // add last row if there are one or two more sake buttons
    int rowAddition = 0;
    if ([arrayOfSakeDictionary count] % 3 != 0) rowAddition = 1;
    
    // set the size of the content to the width of screen and accrosing to the number of buttons
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                        navigationBarY + buttonY
                                        * ([arrayOfSakeDictionary count] / 3
                                           + rowAddition) - navigationBarY);
    
    // set the delegate of scrollview to self
    scrollView.delegate = self;
    
    // add scrollView to main screen
    [bottomScrollView addSubview:scrollView];
}

- (void)viewChangeToDetailWithID:(int)sakeID {
    
    // load the data of sake
    [defaults setInteger:sakeID forKey:@"sakeID"];
    
    UIViewController *dVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"detailViewController"];
    
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    // start transition
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:dVC animated:NO completion:nil];
}

- (void)sakeButtonPushed:(UIButton*) button {
    
    
    [defaults setInteger:(int) button.tag forKey:@"sakeID"];
    
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

- (void)viewChangeButtonPushed:(UIButton*) button {
    // change button picutre to map if it is on grid, else to grid
    if (currentPage == 0) {
        currentPage = 1;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"change_to_grid.png"] forState:UIControlStateNormal];
    } else {
        currentPage = 0;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"change_to_map.png"] forState:UIControlStateNormal];
    }
    CGRect frame = bottomScrollView.frame;
    frame.origin.x = frame.size.width * currentPage;
    frame.origin.y = 0;
    [bottomScrollView scrollRectToVisible:frame animated:YES];
    
    
//    UIViewController *mVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mapViewController"];
//    
//    // initiazlize animation effect to push new view controller from right to left
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromRight;
//    
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentViewController:mVC animated:NO completion:nil];
    
    //[self presentViewController:mVC animated:YES completion:nil];
    //[self.navigationController popToViewController:mVC animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sv {
    
    // get the current page of scroll view if user scroll the view instead of touching botton
    float fractionalPage = sv.contentOffset.x / sv.frame.size.width;
    currentPage = (int) lround(fractionalPage);
    
    // set the picture of button according to the current page
    if (currentPage == 0) {
        [buttonForViewChange setBackgroundImage:nil forState:UIControlStateNormal];
        [buttonForViewChange setImage:[UIImage imageNamed:@"change_to_map.png"] forState:UIControlStateNormal];
    } else {
        [buttonForViewChange setBackgroundImage:nil forState:UIControlStateNormal];
        [buttonForViewChange setImage:[UIImage imageNamed:@"change_to_grid.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
