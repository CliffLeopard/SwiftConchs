//
//  PermissionUtil.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import Foundation
import AVFoundation
import Photos
import UIKit

/// 常用权限申请结果
///
/// authorized：允许授权
/// authorizedAlways：允许授权-总是
/// authorizedWhenInUse：允许授权-仅限使用中
/// denied：拒绝
/// notDetermined：没有决定
/// restricted：受限制的
/// limited：受限制
/// ephemeral：短暂的
/// provisional：临时的
///
/// 官方网址：https://developer.apple.com/documentation/bundleresources/information_property_list/protected_resources

//   麦克风
class PermissionUtil: NSObject {
    
    /// 定位属性
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
    }
    
    static func checkAVCaptureAudioDevice() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .audio)
    }
    
    static func requestAVCaptureAudioDevice(_ completionHandler: @escaping (Bool) -> Void) {
        let audioStatus = checkAVCaptureAudioDevice()
        switch(audioStatus){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: completionHandler)
        default:
            completionHandler(audioStatus == .authorized)
        }
    }
}



//   相机&图片
extension PermissionUtil {
    
    // 检测相机权限
    static func checkAVCaptureVideoDevice() -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    // 申请相机权限
    static func requestAVCaptureVideoDevice(_ completionHandler: @escaping (Bool) -> Void) {
        let videoStatus = checkAVCaptureVideoDevice()
        switch(videoStatus) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: completionHandler)
        default:
            completionHandler(videoStatus == .authorized)
        }
    }
    
    // 检测图片权限
    // level: 读写:PHAccessLevel.readWrite  只写入:PHAccessLevel.addOnly
    static func checkPhotosLibraryUsageStatus(_ level:PHAccessLevel) -> PHAuthorizationStatus {
        var status = PHAuthorizationStatus.notDetermined
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: level)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        return status
    }
    
    
    // 申请图片读取权限
    // level: 读写:PHAccessLevel.readWrite  只写入:PHAccessLevel.addOnly
    static func requestPhotosLibraryUsageStatus(level:PHAccessLevel, _ completionHandler: @escaping (PHAuthorizationStatus) -> Void){
        let status = checkPhotosLibraryUsageStatus(level)
        switch(status){
        case .notDetermined:
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: level, handler: completionHandler)
            } else {
                PHPhotoLibrary.requestAuthorization(completionHandler)
            }
        default :
            completionHandler(status)
        }
    }
}

//  定位
extension PermissionUtil: CLLocationManagerDelegate {
    
    static let instance = PermissionUtil()
    private struct AssociatedKey {
        static var complated = "LocationComplatedKey"
        static var manager = "LocationManager"
    }
    private var complated: ((Bool) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.complated) as? ((Bool) -> Void)? ?? nil
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.complated, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static func checkLocationStatus() -> CLAuthorizationStatus{
        var status = CLAuthorizationStatus.notDetermined
        
        if #available(iOS 14.0, *) {
            status = self.instance.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        return status
    }
    
    static func requestLocationInUse(_ isAuth: ((Bool) -> Void)? = nil) {
        let status = checkLocationStatus()
        if status == .notDetermined {
            self.instance.locationManager.requestAlwaysAuthorization()
            self.instance.complated = isAuth
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            isAuth?(true)
        } else {
            isAuth?(false)
        }
    }
    
    static func requestLocationAlways(_ isAuth: ((Bool) -> Void)? = nil) {
        let status = checkLocationStatus()
        if status == .notDetermined {
            self.instance.locationManager.requestAlwaysAuthorization()
            self.instance.complated = isAuth
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            
            isAuth?(true)
        } else {
            isAuth?(false)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            PermissionUtil.instance.complated?(true)
            break
        default:
            PermissionUtil.instance.complated?(false)
            break
        }
    }
    
}

//  通知
extension PermissionUtil {
    
    static func checkNotificationAvailable(completionHandler: @escaping (UNAuthorizationStatus) -> Void) {
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().getNotificationSettings{ settings in
                completionHandler(settings.authorizationStatus)
            }
        } else {
            let isRegistered = UIApplication.shared.isRegisteredForRemoteNotifications
            if(isRegistered){
                completionHandler(UNAuthorizationStatus.authorized)
            }else {
                completionHandler(UNAuthorizationStatus.denied)
            }
        }
    }
    
    static func requestNotificationAuthorize(_ isAuth: ((Bool) -> Void)? = nil) {
        checkNotificationAvailable { status in
            if status == .notDetermined {
                if #available(iOS 10, *) {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (isAuthor, error) in
                        isAuth?(isAuthor)
                    }
                } else {
                    UIApplication.shared.registerForRemoteNotifications()
                    
                }
            } else if status == .authorized {
                isAuth?(true)
            } else {
                isAuth?(false)
            }
        }
    }
}

