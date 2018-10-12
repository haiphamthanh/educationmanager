////
////  LocaltionUtils.swift
////  ASHManager
////
////  Created by HieuNT52-MC on 1/22/18.
////  Copyright © 2018 Asahi. All rights reserved.
////
//

import CoreLocation
import RxSwift
import MapKit

final class LocationMapKitUtils: NSObject {
	
	static let shared = LocationMapKitUtils()
	var pinAnnotationView: MKPinAnnotationView!
	var location = Variable<CLLocation>(CLLocation())
	var mapView = MKMapView()
	var locationsArray = [MKMapItem]()
	
	fileprivate let edgeInset = UIEdgeInsetsMake(60, 60, 60, 60)
	private let locationManager = CLLocationManager()
	private let authStatus = CLLocationManager.authorizationStatus()
	private var isUpdatingLocation: Bool = false
	
	private override init() {
		super.init()
		
		mapView.mapType = .standard
		mapView.delegate = self
		requestLocationPermisson()
	}
	
	// MARK: ------------------ public functions
	func addAnotationsToMapView(with locationsList: [CLLocation]) {
		for location in locationsList {
			let location2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
			
			let pointAnnotation = GKPointAnnotation()
			pointAnnotation.pinImage =  UIImage(named: "checkpoint_unchecked")
			pointAnnotation.coordinate = location2D
			pointAnnotation.title = "CheckPoint"
			pointAnnotation.subtitle = "Coordinator: \(location)"
			
			pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
			mapView.addAnnotation(pinAnnotationView.annotation!)
		}
	}
	
	func startUpdateLocation() {
		if !isUpdatingLocation {
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
			isUpdatingLocation = true
			locationManager.delegate = self
		}
	}
	
	func stopUpdateLocation() {
		if isUpdatingLocation {
			locationManager.stopUpdatingLocation()
			locationManager.delegate = nil
			isUpdatingLocation = false
		}
	}
	
	func calculateSegmentDirections(index: Int, time: TimeInterval, routes: [MKRoute]) {
		let request: MKDirectionsRequest = MKDirectionsRequest()
		request.source = locationsArray[index]
		request.destination = locationsArray[index+1]
		request.requestsAlternateRoutes = true
		request.transportType = .automobile
		
		let directions = MKDirections(request: request)
		directions.calculate(completionHandler: { [unowned self] (response, error) in
			if let routeResponse = response?.routes {
				let quickestRouteForSegment: MKRoute = routeResponse.sorted(by: { $0.expectedTravelTime < $1.expectedTravelTime })[0]
				var timeVar = time
				var routeVar = routes
				
				routeVar.append(quickestRouteForSegment)
				timeVar += quickestRouteForSegment.expectedTravelTime
				
				if index + 2 < self.locationsArray.count {
					self.calculateSegmentDirections(index: index + 1, time: timeVar, routes: routeVar)
				} else {
					self.showRoute(routes: routeVar)
				}
			} else if let _ = error {
				
			}
		})
	}
	
	// MARK: ------------------ private functions
	private func authorizeLocationPermission() -> CLAuthorizationStatus? {
		switch authStatus {
		case .notDetermined:
			return .notDetermined
		case .denied:
			return .denied
		case .restricted:
			return .restricted
		default:
			return nil
		}
	}
	
	private func requestLocationPermisson() {
		switch authStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			startUpdateLocation()
		default:
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	private func zoomMapToFitAnnotations(mapView: MKMapView) {
		var zoomRect: MKMapRect = MKMapRectNull
		for annotation in mapView.annotations {
			let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
			let pointRect =  MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
			if  MKMapRectIsNull(zoomRect) {
				zoomRect = pointRect
				continue
			}
			
			zoomRect = MKMapRectUnion(zoomRect, pointRect)
		}
		
		mapView.setVisibleMapRect(zoomRect, edgePadding: edgeInset, animated: false)
	}
	
	private func showRoute(routes: [MKRoute]) {
		for route in routes {
			plotPolyline(route: route)
		}
	}
	
	private func plotPolyline(route: MKRoute) {
		mapView.add(route.polyline)
		
		let polylineBoundingRect = mapView.overlays.count == 1 ? route.polyline.boundingMapRect : mapView.visibleMapRect
		mapView.setVisibleMapRect(polylineBoundingRect,
								  edgePadding: edgeInset,
								  animated: false)
	}
}

// MARK: ------------------ CLLocationManagerDelegate
extension LocationMapKitUtils: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let newLocation = locations.last!
		
		if newLocation.horizontalAccuracy < 0 {
			return
		}
		
		if location.value.horizontalAccuracy < newLocation.horizontalAccuracy {
			location.value = newLocation
			
			if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
				stopUpdateLocation()
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
		locationManager.stopUpdatingLocation()
	}
}

// MARK: ------------------ MKMapViewDelegate
extension LocationMapKitUtils: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let reuseIdentifier = "pin"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
		
		if annotationView == nil {
			annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
			annotationView?.canShowCallout = true
		} else {
			annotationView?.annotation = annotation
		}
		
		if let customPointAnnotation = annotation as? GKPointAnnotation {
			annotationView?.image = customPointAnnotation.pinImage
			return annotationView
		}
		
		return nil
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		view.image = ((view.annotation as? GKPointAnnotation) != nil)
			? UIImage(named: "checkpoint_checked") : UIImage(named: "checkpoint_unchecked")
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let polylineRenderer = MKPolylineRenderer(overlay: overlay)
		
		if (overlay is MKPolyline) {
			polylineRenderer.strokeColor = UIColor.blue.withAlphaComponent(0.75)
			polylineRenderer.lineWidth = 5
		}
		
		return polylineRenderer
	}
}
