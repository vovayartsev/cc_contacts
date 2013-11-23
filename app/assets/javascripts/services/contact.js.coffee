angular.module("app").factory "Contact", [ "$resource", ($resource) ->
    actions = {
        'import': {method: 'POST', url: "/contacts/:id/import.json"},
        'available': {method: 'GET', url: "/contacts/available.json", isArray: true}
    }

    $resource "/contacts/:id.json", {id: "@id"}, actions
]


