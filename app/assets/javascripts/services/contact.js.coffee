angular.module("app").factory "Contact", [ "$resource", ($resource) ->
    actions = {
        'save': {method: 'POST'},
        'available': {method: 'GET', url: "/contacts/available.json", isArray: true}
    }

    $resource "/contacts/:id.json", {}, actions
]


