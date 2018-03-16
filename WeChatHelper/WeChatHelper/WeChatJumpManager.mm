//
//  WeChatJumpManager.m
//  IPAPatchFramework
//
//  Created by duzexu on 2018/3/5.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "WeChatJumpManager.h"
#import <UIKit/UIKit.h>
#import "FTFakeTouch.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/types_c.h>

@interface WeChatJumpManager () {
    dispatch_queue_t jump_queue;
    CGRect randomRect;
    
    cv::Mat chess;//棋子模板
    CvRect chessRect;//棋子位置
    CGFloat coefficient;//按压时间系数
}

@end

@implementation WeChatJumpManager

+ (instancetype)sharedManager {
    static WeChatJumpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [WeChatJumpManager new];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        jump_queue = dispatch_queue_create("com.zexu.jumping", DISPATCH_QUEUE_CONCURRENT);
        CGSize size = [UIScreen mainScreen].bounds.size;
        randomRect = CGRectMake(size.width*0.2, size.height*0.6, size.width*0.6, size.height*0.3);
        if (size.width == 320) {
            coefficient = 2.3;
        }else if (size.width == 375) {
            if(size.height == 812) {
                coefficient = 2.6;
            }else{
//                coefficient = 1.95;
                coefficient = 2.34;
            }
//            if (iPhone8) {
//                coefficient = 1.97;
//            }
        }else{
            coefficient = 2.34;
        }
        
        NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"jpg"];
        UIImageToMat([UIImage imageWithContentsOfFile:templatePath], chess);
    }
    return self;
}

- (void)startJump {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    _isJumping = YES;
    dispatch_async(jump_queue, ^{
        while (_isJumping) {
            __block UIImage *screenShot;
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenShot = [self getCurrentScreenShot];
            });
            CGFloat time = [self timeWithImage:screenShot];
            if (time > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CGFloat x = (int)(randomRect.origin.x + (arc4random() % (int)randomRect.size.width));
                    CGFloat y = (int)(randomRect.origin.y + (arc4random() % (int)randomRect.size.height));
                    [[FTFakeTouch sharedInstance] longPressAtPoint:CGPointMake(x, y) duration:time];
                });
                CGFloat sleepT = (arc4random() % 50)/100.0+2.5;
                sleep(sleepT+time);
            }else{
                _isJumping = NO;
            }
        }
    });
}

- (void)stopJump {
    _isJumping = NO;
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

//获取屏幕截图
- (UIImage *)getCurrentScreenShot {
    UIWindow *screenWindow = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, NO, [UIScreen mainScreen].scale);
    [screenWindow drawViewHierarchyInRect:screenWindow.frame afterScreenUpdates:YES];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (CGFloat)timeWithImage:(UIImage *)image {
    @autoreleasepool {
        cv::Mat s;
        UIImageToMat(image, s);
        cv::Mat r = s.clone();
        CvPoint p = [self chess_Loc:s tempImage:chess result:r];
        CvPoint n = [self nextStep_Loc:s chessPoint:p];
        s.release();
        r.release();
        if (n.x != 0&&n.y != 0) {
            double distance = [self distanceBetweenPointA:p pointB:cvPoint(n.x, n.y)];
            return distance*coefficient/1000.0;
        }else{
            return 0.3;
        }
    }
}

- (CvPoint)chess_Loc:(cv::Mat)res tempImage:(cv::Mat)temp result:(cv::Mat)result {
    cv::matchTemplate(res, temp, result, CV_TM_SQDIFF);
    double minVal,maxVal;
    CvPoint minLoc,maxLoc,matchLoc;
    IplImage image = IplImage(result);
    cvMinMaxLoc(&image,&minVal,&maxVal,&minLoc,&maxLoc,NULL);
    matchLoc = minLoc; //matchLoc是最佳匹配的区域左上角点
    chessRect = cvRect(matchLoc.x, matchLoc.y, temp.cols, temp.rows);
//    cv::rectangle(res, cvRect(matchLoc.x, matchLoc.y, temp.cols, temp.rows), cvScalar(225,225,0));
    return cvPoint(matchLoc.x+temp.cols*0.5,matchLoc.y+temp.rows);
}

- (CvPoint)nextStep_Loc:(cv::Mat)res chessPoint:(CvPoint)point {
    cvtColor(res, res, CV_BGR2GRAY);
    cv::GaussianBlur(res,res,cvSize(3,3),0);
    cv::Canny(res, res, 3, 9);
    cv::rectangle(res, chessRect, cvScalar(0), -1);
    int minX = 0,maxX =0;
    int maxY = 0;
    int x = 0;
    if (point.x < res.cols/2.0) {
        for (int j = res.rows*0.25; j < res.rows*0.6; j++) {
            uchar* ptr = res.ptr<uchar>(j);
            for (int i = res.cols/3.0; i < res.cols; i++) {
                if (ptr[i] == 255) {
                    if (minX == 0) {
                        minX = i;
                        maxY = j;
                    }
                    if (i > maxX && j >= maxY) {
                        if (abs(i-maxX) < 5) {
                            maxX = i;
                            maxY = j;
                        }
                    }
                }else{
                    if (minX != 0 && maxX == 0) {
                        maxX = i;
                        x = (int)((maxX-minX)/2.0)+minX;
                    }
                    if (maxY > 0) {
                        if (j-maxY>4 || j == (int)(res.rows*0.6)-1) {
                            [self debugWithRes:res point:cvPoint(x, maxY)];
                            return cvPoint(x, maxY);
                        }
                    }
                }
            }
        }
    }else{
        for (int j = res.rows*0.25; j < res.rows*0.6; j++) {
            uchar* ptr = res.ptr<uchar>(j);
            for (int i = 0; i < res.cols/3.0*2.0; i++) {
                if (ptr[i] == 255) {
                    if (minX == 0) {
                        minX = i;
                        maxY = j;
                    }
                    if (i > maxX && j >= maxY) {
                        if (abs(i-maxX) < 5) {
                            maxX = i;
                            maxY = j;
                        }
                    }
                }else{
                    if (minX != 0 && maxX == 0) {
                        maxX = i;
                        x = (int)((maxX-minX)/2.0)+minX;
                    }
                    if (maxY > 0) {
                        if (j-maxY>4 || j == (int)(res.rows*0.6)-1) {
                            [self debugWithRes:res point:cvPoint(x, maxY)];
                            return cvPoint(x, maxY);
                        }
                    }
                }
            }
        }
    }
    return cvPoint(0, 0);
}

- (double)distanceBetweenPointA:(CvPoint)pa pointB:(CvPoint)pb {
    return pow(pow(pa.x-pb.x,2)+pow(pa.y-pb.y,2),0.5);
}

- (void)debugWithRes:(cv::Mat)res point:(CvPoint)p {
    cv::circle(res, cvPoint(p.x, p.y), 3, cvScalar(255));
    UIImage *i = MatToUIImage(res);
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageWriteToSavedPhotosAlbum(i,nil,nil,nil);
    });
}

@end
