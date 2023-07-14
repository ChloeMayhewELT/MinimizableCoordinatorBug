# MinimizableCoordinatorBug
Reproduction of an issue we're seeing when using TCACoordinators.

If there's more than 2 views pushed onto the coordinator when it's minimized, when it's maximized they all animate in but ultimately everything past index 2 gets removed by an `.updateRoutes` action.
