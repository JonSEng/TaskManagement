(->
  $(document).on "click", ".task_modal", (event) ->
    modal = $(this).parent().find("#task_modal")
    modal.find("#title").val("")
    modal.find("#person").val("")
    modal.find("#notes").val("")
    modal.find("#min_workers").val("")
    modal.find("#max_workers").val("")
    modal.modal("show")

  $(document).on "click", "#show_all_workers", (event) ->
      if $("#all_workers").css("max-height") == "0px"
          $("#all_workers").addClass("sidebar_menu_item_content_show")
      else
          $("#all_workers").removeClass("sidebar_menu_item_content_show")

  $(document).on "click", "#show_add_tasks", (event) ->
      if $("#add_tasks").css("max-height") == "0px"
          $("#add_tasks").addClass("sidebar_menu_item_content_show")
      else
          $("#add_tasks").removeClass("sidebar_menu_item_content_show")

  $(document).on "click", "#show_import_task_templates", (event) ->
      if $("#import_task_templates").css("max-height") == "0px"
          $("#import_task_templates").addClass("sidebar_menu_item_content_show")
      else
          $("#import_task_templates").removeClass("sidebar_menu_item_content_show")

  $(document).on "click", ".lane_ending", (event) ->
    $(this).parent().find(".new_task_modal").modal("show")

)()
