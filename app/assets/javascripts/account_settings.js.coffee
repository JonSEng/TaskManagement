(->
  $(document).on "click", "#show_profile", (event) ->
    $("#profile").show()
    $("#notifications").hide()
    $("#delete_account").hide()

  $(document).on "click", "#show_notifications", (event) ->
    $("#profile").hide()
    $("#notifications").show()
    $("#delete_acount").hide()

  $(document).on "click", "#show_delete_account", (event) ->
    $("#profile").hide()
    $("#notifications").hide()
    $("#delete_account").show()
)()
