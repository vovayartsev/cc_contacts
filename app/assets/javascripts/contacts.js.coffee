jQuery ->
    $placeholder = $("#contacts_form_placeholder")
    if $placeholder.length
        # loading the new contacts form content dynamically with AJAX
        $.get $placeholder.data('href'), (data) ->
            $placeholder.html data
            userIds = $placeholder.find("table").data("user-ids")


