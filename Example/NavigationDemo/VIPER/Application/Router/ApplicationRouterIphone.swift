import UIKit
import Marshroute

final class ApplicationRouterIphone: BaseDemoRouter, ApplicationRouter {
    // MARK: - Private properties
    private let authorizationModuleTrackingService: AuthorizationModuleTrackingService
    
    // MARK: - Init
    init(authorizationModuleTrackingService: AuthorizationModuleTrackingService,
         assemblyFactory: AssemblyFactory,
         routerSeed: RouterSeed)
    {
        self.authorizationModuleTrackingService = authorizationModuleTrackingService
        
        super.init(assemblyFactory: assemblyFactory, routerSeed: routerSeed)
    }
    
    // MARK: - ApplicationRouter
    func authorizationStatus(completion: ((isPresented: Bool) -> ())) {
        let isPresented = authorizationModuleTrackingService.isAuthorizationModulePresented()
        completion(isPresented: isPresented)
    }
    
    func showAuthorization(prepareForTransition: ((moduleInput: AuthorizationModuleInput) -> ())) {
        pushViewControllerDerivedFrom { routerSeed -> UIViewController in
            let authorizationAssembly = assemblyFactory.authorizationAssembly()
            
            let (viewController, moduleInput) = authorizationAssembly.module(
                routerSeed: routerSeed
            )
            
            prepareForTransition(moduleInput: moduleInput)
            
            return viewController
        }
    }
    
    func showCategories() {
        presentModalNavigationControllerWithRootViewControllerDerivedFrom { routerSeed -> UIViewController in
            let subcategoriesAssembly = assemblyFactory.categoriesAssembly()
            
            let viewController = subcategoriesAssembly.module(
                routerSeed: routerSeed
            )
            
            return viewController
        }
    }
    
    func showRecursion() {
        presentModalNavigationControllerWithRootViewControllerDerivedFrom { routerSeed -> UIViewController in
            let recursionAssembly = assemblyFactory.recursionAssembly()
            
            let viewController = recursionAssembly.module(routerSeed: routerSeed)
            
            return viewController
        }
    }
}