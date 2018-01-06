//
//  LocationViewController.h
//  LocationApp
//
//  Created by Andri on 1/5/18.
//  Copyright © 2018 Andri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    UILabel *longitudeLabel;
    UILabel *latitudeLabel;
    UILabel *addressLabel;
}

@end

