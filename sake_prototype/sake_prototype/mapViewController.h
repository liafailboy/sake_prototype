//
//  mapViewController.h
//  sake_prototype
//
//  Created by Shotaro Watanabe on 2/25/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface mapViewController : UINavigationController <GMSMapViewDelegate> {
    NSUserDefaults *defaults;
    
    NSMutableArray *arrayOfSakeDictionary;
}

@end
