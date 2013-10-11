class ContactsTableCtrl
    constructor: (Contact, @timeout) ->
        @available = Contact.available()

    nextContact: ->
        @available[@importedCount]

    importOne: =>
        contact = @nextContact()
        if contact
            console.log contact
            @importedCount += 1

        # returning true if we should schedule next timeout
        !! @nextContact()

    startImport: ->
        @importing = true
        @importedCount = 0

        countdownFn = (hasNext) =>
            @timeout(@importOne).then(countdownFn) if hasNext

        # starting countdown
        countdownFn(true)



    # process status

    isLoading: ->
        ! @available.$resolved

    isImporting: ->
        !! @importing

# registering controller in Angular framework
ContactsTableCtrl.$inject = ['Contact', '$timeout'];
angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
