//
//  Recognizer.m
//  Vratis
//
//  Created by Daniel Budynski on 03/12/2016.
//  Copyright © 2016 Budyn&Friends. All rights reserved.
//

#import "Recognizer.h"
#import "RecognizerDataSource.h"

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

@interface Recognizer()
@property (strong, nonatomic) RecognizerDataSource *dataSource;

@end

@implementation Recognizer

+ (instancetype)sharedInstance {
    static Recognizer *recognizer = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        recognizer = [[Recognizer alloc] init];
    });
    return recognizer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = [[RecognizerDataSource alloc] init];
    }
    return self;
}

- (void)fetchDataSource:(void (^)(NSError *error))completion {
    [self.dataSource performFetch:^(NSError *error){
        completion(error);
    }];
}

#pragma mark OpenCV - recognition methods
- (NSString *)recognizeImage:(UIImage *)cameraImage {
    
    NSString *recognizedImageString = nil;
    int index = -1;
    NSNumber *ac = nil;
    NSNumber *newAc = nil;
    for (int i = 0; i < self.dataSource.count; i = i + 1) {
        UIImage *databaseImage = [self.dataSource imageForIndex:i];
        ac = [self compareImage:cameraImage with:databaseImage];
        if (i != 0) {
            if ([ac doubleValue] > [newAc doubleValue]) {
                newAc = ac;
                index = i;
            }
        } else {
            newAc = ac;
            index = i;
        }
    }
    if (index == 0) {
        recognizedImageString = @"Obiekt 1";
    } else if (index == 1) {
        recognizedImageString = @"Obiekt 2";
    } else if (index == 2) {
        recognizedImageString = @"Obiekt 2";
    }else if (index == 3) {
        recognizedImageString = @"Obiekt 3";
    }else if (index == 4) {
        recognizedImageString = @"Obiekt 4";
    }else if (index == 5) {
        recognizedImageString = @"Obiekt 5";
    }else if (index == 6) {
        recognizedImageString = @"Obiekt 6";
    }
    else {
        recognizedImageString = @"Nie rozpoznano";
    }
    return recognizedImageString;
}

- (NSNumber*)compareImage:(UIImage *)cameraImage with:(UIImage *)databaseImage {
    using namespace cv;
    // Image to MAT
    Mat RGBCameraImage;
    UIImageToMat(cameraImage, RGBCameraImage);
    
    Mat RGBDatabaseImage;
    UIImageToMat(databaseImage, RGBDatabaseImage);

    // RGB to HSV
    Mat HSVCameraImage;
    cvtColor(RGBCameraImage, HSVCameraImage, COLOR_BGR2HSV);
    
    Mat HSVDatabaseImage;
    cvtColor(RGBDatabaseImage, HSVDatabaseImage, COLOR_BGR2HSV);
    
    int hueBinCount = 50;
    int saturationBinCount = 60;
    int histogramSize[] = {hueBinCount, saturationBinCount};
    
    float hueRanges[] = { 0, 180};
    float saturationRanges[] = { 0, 256};
    const float* ranges[] = {hueRanges, saturationRanges};
    int channels[] = {0, 1};
    
    MatND HSVCameraImageHistogram;
    calcHist(&HSVCameraImage, 1, channels, Mat(), HSVCameraImageHistogram, 2, histogramSize, ranges, true, false);
    normalize(HSVCameraImageHistogram, HSVCameraImageHistogram, 0, 1, NORM_MINMAX, -1, Mat());
    
    MatND HSVDatabaseImageHistogram;
    calcHist(&HSVDatabaseImage, 1, channels, Mat(), HSVDatabaseImageHistogram, 2, histogramSize, ranges, true, false);
    normalize(HSVDatabaseImageHistogram, HSVDatabaseImageHistogram, 0, 1, NORM_MINMAX, -1, Mat());
    
    double ac = compareHist(HSVCameraImageHistogram, HSVDatabaseImageHistogram, 2);

    return [NSNumber numberWithDouble:ac];
}


@end
