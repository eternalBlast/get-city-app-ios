//
//  LocationViewController.m
//  LocationApp
//
//  Created by Andri on 1/5/18.
//  Copyright © 2018 Andri. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Get Current Location";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(24);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel *latitudeTitle = [UILabel new];
    latitudeTitle.text = @"Your Latitude";
    [self.view addSubview:latitudeTitle];
    [latitudeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8);
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
    }];
    
    latitudeLabel = [UILabel new];
    latitudeLabel.text = @"Latitude Value";
    [self.view addSubview:latitudeLabel];
    [latitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.insets(UIEdgeInsetsMake(0, 0, 0, 8));
        make.top.equalTo(latitudeTitle);
    }];
    
    UILabel *longitudeTitle = [UILabel new];
    longitudeTitle.text = @"Your Longitude";
    [self.view addSubview:longitudeTitle];
    [longitudeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(latitudeTitle);
        make.top.equalTo(latitudeTitle.mas_bottom).offset(8);
    }];
    
    longitudeLabel = [UILabel new];
    longitudeLabel.text = @"Longitude Value";
    [self.view addSubview:longitudeLabel];
    [longitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.insets(UIEdgeInsetsMake(0, 0, 0, 8));
        make.top.equalTo(longitudeTitle);
    }];
    
    UILabel *addressTitle = [UILabel new];
    addressTitle.text = @"Longitude Value";
    [self.view addSubview:addressTitle];
    [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(longitudeTitle);
        make.top.equalTo(longitudeTitle.mas_bottom).offset(8);
    }];
    
    addressLabel = [UILabel new];
    addressLabel.text = @"Address Value";
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.insets(UIEdgeInsetsMake(0, 0, 0, 8));
        make.top.equalTo(addressTitle);
    }];
    
    UIButton *getLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getLocationButton setTitle:@"Get current location" forState:UIControlStateNormal];
    [self.view addSubview:getLocationButton];
    [getLocationButton addTarget:self action:@selector(getDidTap) forControlEvents:UIControlEventTouchUpInside];
    [getLocationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [getLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(addressLabel.mas_bottom).offset(16);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDidTap{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;

    latitudeLabel.text = [NSString stringWithFormat:@"%f", latitude];
    longitudeLabel.text = [NSString stringWithFormat:@"%f", longitude];
    
    addressLabel.text = @"Processing...";
    
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark* placemark = [placemarks lastObject];
             NSString *ploc = placemark.subLocality;
             if (!ploc) {
                 ploc = placemark.locality;
             }
             addressLabel.text = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.country];
         }
     }];
    
}

@end
