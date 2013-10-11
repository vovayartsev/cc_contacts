class ContactsTableCtrl
    constructor: ($scope, Contact) ->
        @available = Contact.available()

    startImport: ->
        @importing = true
        @importedCount = 0

    # process status

    isLoading: ->
        ! @available.$resolved

    isImporting: ->
        !! @importing

# registering controller in Angular framework
ContactsTableCtrl.$inject = ['$scope', 'Contact'];
angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
