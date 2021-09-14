//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

class Coordinator {
    private static let NO_ARGUMENTS = 0
    private static let ONE_ARGUMENT = 1
    private static let TWO_ARGUMENTS = 2

    private static let FIRST_ARGUMENT = 0
    private static let SECOND_ARGUMENT = 1

    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func pushViewController<V: UIViewController>(
        viewController: UIViewController,
        newViewControllerType: V.Type
    ) {
        var newViewController: V!
        newViewController = resolveNoArguments(newViewControllerType)
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }

    /// Pushes the specified _UIViewController_ to instance. If there already is more than one UIViewController on
    /// the stack, it will remove all instances in between the specified _UIViewController_ and the existent
    /// _rootViewController_ in the related _UINavigationController_.
    func setViewController<V: UIViewController, T>(
        viewController: UIViewController,
        newViewControllerType: V.Type,
        args: [T] = []
    ) {
        var newViewController: V!
        switch args.count {
        case Coordinator.NO_ARGUMENTS:
            newViewController = resolveNoArguments(newViewControllerType)
        case Coordinator.ONE_ARGUMENT:
            newViewController = resolveOneArgument(newViewControllerType, args)
        case Coordinator.TWO_ARGUMENTS:
            newViewController = resolveTwoArguments(newViewControllerType, args)
        default:
            fatalError("Unsupported number of arguments (max. 2)")
        }

        if let root = viewController.navigationController?.viewControllers.first {
            viewController.navigationController?.setViewControllers([root, newViewController], animated: true)
        } else {
            viewController.navigationController?.setViewControllers([newViewController], animated: true)
        }
    }

    func pushViewController<V: UIViewController, T>(
        viewController: UIViewController,
        newViewControllerType: V.Type,
        args: [T]
    ) {
        var newViewController: V!
        let totalArgs = args.count
        if totalArgs == Coordinator.NO_ARGUMENTS {
            newViewController = resolveNoArguments(newViewControllerType)
        } else if totalArgs == Coordinator.ONE_ARGUMENT {
            newViewController = resolveOneArgument(newViewControllerType, args)
        } else if totalArgs == Coordinator.TWO_ARGUMENTS {
            newViewController = resolveTwoArguments(newViewControllerType, args)
        }
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }

    func presentLikeBottomSheet<V: UIViewController>(
        viewController: UIViewController,
        newViewControllerType: V.Type
    ) {
        let newViewController = resolveNoArguments(newViewControllerType)
        newViewController.modalPresentationStyle = .overFullScreen
        viewController.present(newViewController, animated: false, completion: nil)
    }

    func presentLikeBottomSheet<V: UIViewController, T>(
        viewController: UIViewController,
        newViewControllerType: V.Type,
        args: [T]
    ) {
        var newViewController: V
        switch args.count {
        case Coordinator.NO_ARGUMENTS:
            newViewController = resolveNoArguments(newViewControllerType)
        case Coordinator.ONE_ARGUMENT:
            newViewController = resolveOneArgument(newViewControllerType, args)
        case Coordinator.TWO_ARGUMENTS:
            newViewController = resolveTwoArguments(newViewControllerType, args)
        default:
            fatalError("Unsupported number of arguments (max. 2)")
        }
        newViewController.modalPresentationStyle = .overFullScreen
        viewController.present(newViewController, animated: false, completion: nil)
    }

    func presentLikeNewNavigation<V: UIViewController>(
        viewController: UIViewController,
        newViewControllerType: V.Type,
        style: UIModalPresentationStyle = .fullScreen
    ) {
        let newViewController = resolveNoArguments(newViewControllerType)
        let nv = UINavigationController.init(rootViewController: newViewController)
        nv.modalTransitionStyle = .crossDissolve
        nv.modalPresentationStyle = style
        viewController.present(nv, animated: true, completion: nil)
    }

    func presentLikeNewNavigation<V: UIViewController, T>(
        viewController: UIViewController,
        newViewControllerType: V.Type,
        completion: (() -> Void)? = nil,
        args: [T],
        style: UIModalPresentationStyle = .fullScreen,
        transitionStyle: UIModalTransitionStyle = .coverVertical
    ) {
        var newViewController: V
        switch args.count {
        case Coordinator.NO_ARGUMENTS:
            newViewController = resolveNoArguments(newViewControllerType)
        case Coordinator.ONE_ARGUMENT:
            newViewController = resolveOneArgument(newViewControllerType, args)
        case Coordinator.TWO_ARGUMENTS:
            newViewController = resolveTwoArguments(newViewControllerType, args)
        default:
            fatalError("Unsupported number of arguments (max. 2)")
        }
        let navigationController = UINavigationController(rootViewController: newViewController)
        navigationController.modalPresentationStyle = style
        navigationController.modalTransitionStyle = transitionStyle
        viewController.present(navigationController, animated: true, completion: completion)
    }

    func dismissCurrentNavigation(
        viewController: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        viewController.navigationController?.dismiss(animated: true, completion: completion)
    }

    private func resolveNoArguments<V: UIViewController>(_ newViewControllerType: V.Type) -> V {
        return container.resolve(V.self)!
    }

    private func resolveOneArgument<V: UIViewController, T>(
        _ newViewControllerType: V.Type,
        _ args: [T]
    ) -> V {
        return container.resolve(V.self, argument: args[Coordinator.FIRST_ARGUMENT])!
    }

    private func resolveTwoArguments<V: UIViewController, T>(
        _ newViewControllerType: V.Type,
        _ args: [T]
    ) -> V {
        return container.resolve(
            V.self,
            arguments: args[Coordinator.FIRST_ARGUMENT],
            args[Coordinator.SECOND_ARGUMENT]
        )!
    }
}

