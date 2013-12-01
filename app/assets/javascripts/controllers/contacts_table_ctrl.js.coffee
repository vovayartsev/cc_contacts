class ContactsTableCtrl
    constructor: (Contact) ->
        @available = Contact.available()

    nextContact: ->
        @available[@importedCount]

    importOne: =>
        contact = @nextContact()
        if contact
            @importedCount += 1
            contact.$import().then =>
                @importOne()
        else
            @importing = false
            @finished = true

    startImport: ->
        @importing = true
        @importedCount = 0
        @importOne() for [1..5]  # multithreading


    # process status

    isLoading: ->
        !@available.$resolved

    isImporting: ->
        !!@importing

    hasToImport: ->
        @available.$resolved && @available.length > 0

    importFinished: ->
        !!@finished

# registering controller in Angular framework
ContactsTableCtrl.$inject = ['Contact'];
angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
