//
//  PolylineHelper.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

enum PolylineHelper {
    static func makeCubicBezierPathPoints(
        from start: MKMapPoint,
        to end: MKMapPoint,
        pathPointCount: Int
    ) -> [MKMapPoint] {
        let middle = middlePoint(between: start, and: end)
        let controlPoint1 = thirdPointOfEquilateralTriangle(pointA: middle.cgPoint, pointB: start.cgPoint)
        let controlPoint2 = thirdPointOfEquilateralTriangle(pointA: middle.cgPoint, pointB: end.cgPoint)
        let result = buildPoints(
            start: start.cgPoint,
            end: end.cgPoint,
            controlPoint1: controlPoint1,
            controlPoint2: controlPoint2,
            numberOfPoints: pathPointCount
        )
        return result.map { $0.mkMapPoint }
    }

    private static func middlePoint(between point1: MKMapPoint, and point2: MKMapPoint) -> MKMapPoint {
        let x = point1.x + 0.5 * (point2.x - point1.x)
        let y = point1.y + 0.5 * (point2.y - point1.y)
        return MKMapPoint(x: x, y: y)
    }

    static func directionBetweenPoints(
        _ sourcePoint: MKMapPoint,
        _ destinationPoint: MKMapPoint
    ) -> CLLocationDirection {
        let x = destinationPoint.x - sourcePoint.x
        let y = destinationPoint.y - sourcePoint.y
        return radiansToDegrees(radians: atan2(y, x)).truncatingRemainder(dividingBy: 360) + 90
    }

    private static func thirdPointOfEquilateralTriangle(pointA: CGPoint, pointB: CGPoint) -> CGPoint {
        let x1 = pointA.x
        let y1 = pointA.y
        let x2 = pointB.x
        let y2 = pointB.y
        let u = x2 - x1
        let v = y2 - y1
        let a2 = sqrt(u * u + v * v)
        var RHS1 = x1 * u + y1 * v
        RHS1 += a2 * a2 * cos(CGFloat.pi / 3)
        var RHS2 = y2 * u - x2 * v
        RHS2 += a2 * a2 * sin(CGFloat.pi / 3)
        let x3 = (1 / (a2 * a2)) * (u * RHS1 - v * RHS2)
        let y3 = (1 / (a2 * a2)) * (v * RHS1 + u * RHS2)
        return CGPoint(x: x3, y: y3)
    }

    static func radiansToDegrees(radians: Double) -> Double {
        return radians * 180 / Double.pi
    }

    static func degreesToRadians(degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }

    private static func buildPoints(
        start: CGPoint,
        end: CGPoint,
        controlPoint1: CGPoint,
        controlPoint2: CGPoint,
        numberOfPoints: Int
    ) -> [CGPoint] {
        let step = 1.0 / CGFloat(numberOfPoints - 1)
        var percent: CGFloat = 0
        var points: [CGPoint] = []
        (0..<numberOfPoints).forEach { _ in
            let x = cubicBezier(
                percent: percent,
                start: start.x,
                end: end.x,
                control1: controlPoint1.x,
                control2: controlPoint2.x
            )
            let y = cubicBezier(
                percent: percent,
                start: start.y,
                end: end.y,
                control1: controlPoint1.y,
                control2: controlPoint2.y
            )
            points.append(CGPoint(x: x, y: y))
            percent += step
        }
        return points
    }

    private static func cubicBezier(
        percent: CGFloat,
        start: CGFloat,
        end: CGFloat,
        control1: CGFloat,
        control2: CGFloat
    ) -> CGFloat {
        let offset = 1.0 - percent
        let offsetPow2 = pow(offset, 2)
        let offsetPow3 = pow(offset, 3)
        let percentPow2 = pow(percent, 2)
        let percentPow3 = pow(percent, 3)
        return start * offsetPow3
            + 3 * control1 * offsetPow2 * percent
            + 3 * control2 * offset * percentPow2
            + end * percentPow3
    }
}
