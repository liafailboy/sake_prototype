//
//  ViewController.h
//  sake_prototype
//
//  Created by Shotaro Watanabe on 2/20/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface mainViewController : UIViewController <UIScrollViewDelegate, GMSMapViewDelegate> {
    
    // scrollviews for vertical and horizontal
    UIScrollView *bottomScrollView;
    UIScrollView *scrollView;
    
    UIButton *buttonForViewChange;
    
    // label at the top of navigation bar
    UILabel *titleLabel;
    
    // location of button adn current page index
    int buttonX;
    int buttonY;
    int currentPage;
    
    NSDictionary *sakeDictionary;
        
    NSMutableArray *arrayOfSakeDictionary;
    NSMutableArray *arrayOfDrunkSakeID;
    
    NSUserDefaults *defaults;
}

@end

