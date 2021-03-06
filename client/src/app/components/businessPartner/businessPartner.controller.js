export class BusinessPartnerController {
  constructor($rootScope, $mdEditDialog, $q, $scope, $timeout, businessPartner) {
    'ngInject';

    $scope.selected = [];
    $scope.limitOptions = [5, 10, 15];
    $scope.selected_item = [];

    $scope.options = {
      rowSelection: true,
      multiSelect: false,
      autoSelect: true,
      decapitate: false,
      largeEditDialog: false,
      boundaryLinks: false,
      limitSelect: true,
      pageSelect: true
    };

    $scope.query = {
      order: 'name',
      limit: 5,
      page: 1
    };

    let that = this

    businessPartner.query().then(function(results) {
      that.businessPartners = results;
    });

    $scope.toggleLimitOptions = function () {
      $scope.limitOptions = $scope.limitOptions ? undefined : [5, 10, 15];
    };

    $scope.loadStuff = function () {
      inputInvoice.query().then(function(results) {
        this.inputInvoices = results;
      });

      $scope.promise = $timeout(function () {
        // loading
      }, 2000);
    }

    $scope.logItem = function (item) {
      $scope.selected_item = item;
      $rootScope.$broadcast('changedBusinessPartner', item);
    };

    $scope.$on('closedInvoice', function(event, item) {
      $rootScope.$broadcast('changedBusinessPartner', $scope.selected_item);
    });

    $scope.logOrder = function (order) {
      console.log('order: ', order);
    };

    $scope.logPagination = function (page, limit) {
      console.log('page: ', page);
      console.log('limit: ', limit);
    }
  }
}
