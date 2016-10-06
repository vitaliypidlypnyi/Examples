"use strict";

angular.module("UserAccounts")
    .controller("UserAccountController", UserAccountController);

UserAccountController.$inject = ["$scope", "userAccountService"];

function UserAccountController($scope, userAccountService) {
    var vm = this;
    vm.pageLoading = true;
    vm.inactiveUsersLoaded = false;
    (function() {
        getUsersFromDb(true);
    })();

    function getUsersFromDb(getActive) {
        userAccountService.getFromDb(getActive).then(successCallback, errorCallback);

        function successCallback(response) {
            vm.users = getActive ? response.data : vm.users.concat(response.data);
            vm.pageLoading = false;
        }

        function errorCallback(response) {
            vm.getFromDbMessage = response.data;
            vm.pageLoading = false;
        }
    }

    vm.syncUsers = function() {
        vm.syncInProgress = true;
        userAccountService.syncUsers().then(successCallback, errorCallback);

        function successCallback(response) {
            getUsersFromDb();
            vm.syncInProgress = false;
        }

        function errorCallback(response) {
            vm.syncMessage = response.data;
            vm.syncInProgress = false;
        }
    };

    vm.showUsers = function() {
        if ($scope.showAll && !vm.inactiveUsersLoaded) {
            vm.pageLoading = true;
            getUsersFromDb(false);
            vm.inactiveUsersLoaded = true;
        }
    };

    vm.usersFilter = function(user) {
        return user.IsActive || $scope.showAll;
    };
}