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
    
    int buttonX;
    int buttonY;
    int currentPage;
    
    NSDictionary *sakeDictionary;
        
    NSMutableArray *arrayOfSakeDictionary;
    
    NSUserDefaults *defaults;
}

@end

