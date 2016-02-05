import UIKit

final class TabBarTransitionsHandlerImpl {
    private weak var tabBarController: UITabBarController?
    let transitionsCoordinator: TransitionsCoordinator
    
    init(tabBarController: UITabBarController,
        transitionsCoordinator: TransitionsCoordinator)
    {
        self.tabBarController = tabBarController
        self.transitionsCoordinator = transitionsCoordinator
    }
    
    var tabTransitionsHandlers: [TransitionsHandler]? {
        didSet {
            if let tabBarController = tabBarController {
                assert(tabTransitionsHandlers?.count == tabBarController.viewControllers?.count)
            }
        }
    }
}

// MARK: - TransitionsHandler
extension TabBarTransitionsHandlerImpl: TransitionsHandler { }

//MARK: - TransitionsCoordinatorStorer
extension TabBarTransitionsHandlerImpl: TransitionsCoordinatorStorer {}

//MARK: - TransitionsHandlersContainer
extension TabBarTransitionsHandlerImpl: TransitionsHandlersContainer {
    var allTransitionsHandlers: [TransitionsHandler]? {
        return tabTransitionsHandlers
    }
    
    var visibleTransitionsHandlers: [TransitionsHandler]? {
        if let selectedTransitionsHandler = selectedTransitionsHandler {
            return [selectedTransitionsHandler]
        }
        return nil
    }
}

// MARK: - helpers
private extension TabBarTransitionsHandlerImpl {
    var selectedTransitionsHandler: TransitionsHandler? {
        if let tabTransitionsHandlers = tabTransitionsHandlers {
            if let tabBarController = tabBarController {
            if tabBarController.selectedIndex < tabTransitionsHandlers.count {
                return tabTransitionsHandlers[tabBarController.selectedIndex]
            }
        }
        }
        return nil
    }
}