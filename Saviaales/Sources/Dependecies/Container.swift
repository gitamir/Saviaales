//
//  Container.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

class Container: DependencyContainer {
    typealias ProtocolResolver = (Any) -> Void

    private var protocolResolvers: [ProtocolResolver] = []

    private func register(_ resolver: @escaping ProtocolResolver) {
        protocolResolvers.append(resolver)
    }

    func register<D>(_ resolver: @escaping (inout D) -> Void) {
       register { object in
           guard var object = object as? D else { return }

           resolver(&object)
       }
   }

    func resolve(_ object: Any?) {
        guard let object = object else { return }

        protocolResolvers.forEach { resolver in
            resolver(object)
        }
    }
}
