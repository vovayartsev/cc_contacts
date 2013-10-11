class ContactsTableCtrl
    constructor: ($scope, Contact) ->
        @loading = true

        @available = Contact.available =>
            @loading = false

angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
ContactsTableCtrl.$inject = ['$scope', 'Contact'];
