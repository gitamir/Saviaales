//
//  MapViewController.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    private enum Constants {
        static let flightpathPointCount = 300
        static let mapPadding: UIEdgeInsets = .init(top: 100, left: 100, bottom: 100, right: 100)
        static let planeMovingStep = 5
    }

    struct Input {
        let departureAirport: Airport
        let destinationAirport: Airport
    }

    var input: Input!

    @IBOutlet private var mapView: MKMapView!
    private var flightpathPolyline: MKPolyline?
    private var planeAnnotation: PlaneAnnotation?
    private var planeAnnotationView: MKAnnotationView?
    private var planeAnnotationPositionIndex = 0
    private var planePositionUpdateTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        invalidatePlanePositionUpdateTimer()
    }

    private func setupUI() {
        title = "\(input.departureAirport.iata) – \(input.destinationAirport.iata)"
        view.backgroundColor = Style.Color.themeBlue
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        mapView.register(
            AirportAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: AirportAnnotationView.reuseIdentifier
        )
        mapView.register(
            PlaneAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.reuseIdentifier
        )
        setupMapOverlays()
        updatePlanePosition()
        setupPlanePositionUpdateTimer()
    }

    private func setupMapOverlays() {
        let departureAnnotation = AirportAnnotation(airport: input.departureAirport)
        let destinationAnnotation = AirportAnnotation(airport: input.destinationAirport)
        mapView.addAnnotations([ departureAnnotation, destinationAnnotation ])

        let flightpathPoints = PolylineHelper.makeCubicBezierPathPoints(
            from: MKMapPoint(departureAnnotation.coordinate),
            to: MKMapPoint(destinationAnnotation.coordinate),
            pathPointCount: Constants.flightpathPointCount
        )
        let flightpathPolyline = MKPolyline(points: flightpathPoints, count: flightpathPoints.count)
        self.flightpathPolyline = flightpathPolyline
        mapView.addOverlay(flightpathPolyline)

        let planeAnnotation = PlaneAnnotation(
            planeImage: UIImage(named: "icon-plane-default") ?? UIImage(),
            coordinate: departureAnnotation.coordinate
        )
        self.planeAnnotation = planeAnnotation
        mapView.addAnnotation(planeAnnotation)

        var zoomRect: MKMapRect = .null
        for annotation in mapView.annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
            zoomRect = zoomRect.union(pointRect)
        }
        mapView.setVisibleMapRect(zoomRect, edgePadding: Constants.mapPadding, animated: false)
    }

    private func setupPlanePositionUpdateTimer() {
        if planePositionUpdateTimer != nil {
            invalidatePlanePositionUpdateTimer()
        }

        let timer = Timer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(updatePlanePosition),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: .common)
        planePositionUpdateTimer = timer
    }

    private func invalidatePlanePositionUpdateTimer() {
        planePositionUpdateTimer?.invalidate()
        planePositionUpdateTimer = nil
    }

    @objc private func updatePlanePosition() {
        guard
            let flightpathPolyline = flightpathPolyline,
            let planeAnnotation = planeAnnotation,
            planeAnnotationPositionIndex + Constants.planeMovingStep < flightpathPolyline.pointCount
        else { return invalidatePlanePositionUpdateTimer() }

        let points = flightpathPolyline.points()
        let previousMapPoint = points[planeAnnotationPositionIndex]
        planeAnnotationPositionIndex += Constants.planeMovingStep
        let nextMapPoint = points[planeAnnotationPositionIndex]
        let planeDirection = PolylineHelper.directionBetweenPoints(previousMapPoint, nextMapPoint)
        let rotationAngle = PolylineHelper.degreesToRadians(degrees: planeDirection - 90)
        UIView.animate(
            withDuration: planeAnnotationPositionIndex == Constants.planeMovingStep ? 0 : 1,
            delay: 0,
            options: [ .beginFromCurrentState, .allowUserInteraction ],
            animations: {
                planeAnnotation.coordinate = nextMapPoint.coordinate
                self.planeAnnotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            },
            completion: nil
        )
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer(overlay: overlay) }

        let renderer = MKPolylineRenderer(overlay: polyline)
        renderer.strokeColor = Style.Color.transparentBlue
        renderer.lineWidth = 2
        renderer.lineDashPattern = [2, 6]
        return renderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        switch annotation {
            case let annotation as AirportAnnotation:
                let view: AirportAnnotationView = .dequeue(from: mapView)
                view.update(with: annotation.airport)
                return view
            case let annotation as PlaneAnnotation:
                let view: PlaneAnnotationView = .dequeue(from: mapView)
                view.image = annotation.planeImage
                view.isSelected = true
                planeAnnotationView = view
                return view
            default:
                return nil
        }
    }
}
