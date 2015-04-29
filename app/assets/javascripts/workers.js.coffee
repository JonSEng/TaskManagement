(->
  $(document).on "click", ".show_edit_worker", (event) ->
    $(this).parent().find("#edit_worker").modal('show')

  $(document).on "click", "#edit_worker_info", (event) ->
    $(this).parent().parent().parent().parent().find(".worker_info").show()
    $(this).parent().parent().parent().parent().find(".worker_tasks").hide()
    $(this).parent().parent().parent().parent().find(".delete_worker").hide()

  $(document).on "click", "#edit_worker_assignments", (event) ->
    $(this).parent().parent().parent().parent().find(".worker_info").hide()
    $(this).parent().parent().parent().parent().find(".worker_tasks").show()
    $(this).parent().parent().parent().parent().find(".delete_worker").hide()

  $(document).on "click", "#delete_worker", (event) ->
    $(this).parent().parent().parent().parent().find(".worker_info").hide()
    $(this).parent().parent().parent().parent().find(".worker_tasks").hide()
    $(this).parent().parent().parent().parent().find(".delete_worker").show()

)()
