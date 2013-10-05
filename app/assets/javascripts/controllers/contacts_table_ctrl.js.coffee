angular.module('app').controller "ContactsTableCtrl", [ '$scope', 'Contact',  ($scope, Contact) ->

    $scope.loading = true

    $scope.availableContacts = Contact.available ->
        $scope.loading = false

]