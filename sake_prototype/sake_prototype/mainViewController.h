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
    
    UIScrollView *bottomScrollView;
    UIScrollView *scrollView;
    
    UIButton *buttonForViewChange;
    
    UILabel *titleLabel;
    
    int buttonX;
    int buttonY;
    int currentPage;
    
    NSDictionary *sakeDictionary;
        
    NSMutableArray *arrayOfSakeDictionary;
    NSMutableArray *arrayOfDrunkSakeID;
    
    NSUserDefaults *defaults;
}

@end

