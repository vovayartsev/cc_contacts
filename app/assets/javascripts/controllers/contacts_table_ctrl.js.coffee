class ContactsTableCtrl
    constructor: (Contact, @timeout) ->
        @available = Contact.available()

    nextContact: ->
        @available[@importedCount]

    importOne: =>
        contact = @nextContact()
        if contact
            @importedCount += 1
            contact.$import().then => @importOne()
        else
            @importing = false
            @finished = true
            console.log "DONE!!!"

    startImport: ->
        @importing = true
        @importedCount = 0
        @importOne()


    # process status

    isLoading: ->
        ! @available.$resolved

    isImporting: ->
        !! @importing

    hasToImport: ->
        @available.$resolved && @available.length > 0

    importFinished: ->
        !!@finished

# registering controller in Angular framework
ContactsTableCtrl.$inject = ['Contact', '$timeout'];
angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
