class ContactsTableCtrl
    constructor: (Contact) ->
        @stateMachine = StateMachine.create(
            initial: 'scanning',
            events: [
                { name: 'found', from: 'scanning', to: 'waiting_for_decision' },
                { name: 'empty', from: 'scanning', to: 'nothing_to_import' },
                { name: 'start', from: 'waiting_for_decision', to: 'importing' },
                { name: 'finish', from: ['importing', 'finished'], to: 'finished' }
            ]
        )

        # we start scanning immediately after page load
        @available = Contact.available =>
            if @available.length
                @stateMachine.found() # we found contacts to import
            else
                @stateMachine.empty() # Urrra-a-a!!! nothing to import!

    # this method is called in the view to choose from five jumbotron states
    state: ->
        @stateMachine.current

    nextContact: ->
        @available[@importedCount]

    importOne: =>
        contact = @nextContact()
        if contact
            @importedCount += 1
            contact.$import().then =>
                @importOne()
        else
            @runningThreads -= 1
            @stateMachine.finish() if @runningThreads == 0 # no more contacts to import

    startImport: ->
        @stateMachine.start()
        @importedCount = 0
        @runningThreads = 5
        @importOne() for [1..@runningThreads] # multithreading


# registering controller in Angular framework
ContactsTableCtrl.$inject = ['Contact'];
angular.module('app').controller "ContactsTableCtrl", ContactsTableCtrl
