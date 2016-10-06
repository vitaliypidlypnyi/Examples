"use strict";

angular.module("UserAccounts")

.factory("userAccountService", ["$http", function ($http) {
        var service = {};

        service.getFromDb = function (active) {
            return $http.get("users", { params: { getActive: active } });
        };
        service.syncUsers = function () {
            return $http.get("users/sync");
        };
        return service;
}]);
