//
//  BMFAnnotationViewManager.m
//  flutter_baidu_mapapi_map
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import "BMFAnnotationViewManager.h"

#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>

#import "BMFAnnotation.h"
#import "BMFFileManager.h"
#import "BMFClusterAnnotation.h"

@implementation BMFAnnotationViewManager

#pragma mark - annotationView
+ (BMFAnnotationModel *)annotationModelfromAnnotionView:(BMKAnnotationView *)view {
    return (BMFAnnotationModel *)((BMKPointAnnotation *)view.annotation).flutterModel;
}
/// 根据anntation生成对应的View
+ (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    /// 点聚合类兼容Android做的逻辑，后续可以删除，使用BMKAnnotation的这一套
    if ([annotation isKindOfClass:[BMFClusterAnnotation class]]) {
        BMFAnnotationModel *model = (BMFAnnotationModel *)((BMKPointAnnotation *)annotation).flutterModel;
        NSString *identifier = model.identifier ? model.identifier : NSStringFromClass([BMFClusterAnnotation class]);
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        if (model.iconData) {
            UIImage *image = [UIImage imageWithData:((FlutterStandardTypedData *)model.iconData).data];
            annotationView.image = image;
        }
        else if (model.icon) {
            annotationView.image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:model.icon]];
        }
        
        annotationView.enabled = YES;
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMFAnnotationModel *model = (BMFAnnotationModel *)((BMKPointAnnotation *)annotation).flutterModel;
        NSString *identifier = model.identifier ? model.identifier : NSStringFromClass([BMKPointAnnotation class]);
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        if (model.iconData) {
            UIImage *image = [UIImage imageWithData:((FlutterStandardTypedData *)model.iconData).data];
            annotationView.image = image;
        }
        else if (model.icon) {
            annotationView.image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:model.icon]];
        }
        
        if (model.centerOffset) {
            annotationView.centerOffset = [model.centerOffset toCGPoint];
        }
        annotationView.canShowCallout = model.canShowCallout;
        annotationView.selected = model.selected;
        annotationView.draggable = model.draggable;
        annotationView.enabled = model.enabled;
        annotationView.enabled3D = model.enabled3D;
        annotationView.hidePaopaoWhenDrag = model.hidePaopaoWhenDrag;
        annotationView.hidePaopaoWhenDragOthers = model.hidePaopaoWhenDragOthers;
        annotationView.hidePaopaoWhenSelectOthers = model.hidePaopaoWhenSelectOthers;
        annotationView.hidePaopaoWhenDoubleTapOnMap = model.hidePaopaoWhenDoubleTapOnMap;
        annotationView.hidePaopaoWhenTwoFingersTapOnMap = model.hidePaopaoWhenTwoFingersTapOnMap;
        annotationView.displayPriority = (float)model.displayPriority;
        annotationView.isOpenCollisionDetection = model.isOpenCollisionDetection;
        annotationView.collisionDetectionPriority = model.collisionDetectionPriority;
        annotationView.isForceDisplay = model.isForceDisplay;
        annotationView.isOpenCollisionDetectionWithMapPOI = model.isOpenCollisionDetectionWithMapPOI;
        annotationView.isOpenCollisionDetectionWithPaoPaoView = model.isOpenCollisionDetectionWithPaoPaoView;
        return annotationView;
    }
    return nil;
}

@end
