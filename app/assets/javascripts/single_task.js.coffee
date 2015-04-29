(->
  $(document).on "click", "#all_subtasks", (event) ->
    $(this).parent().parent().parent().parent().find(".add_subtask").hide()
    $(this).parent().parent().parent().parent().find(".all_subtasks").show()
    $(this).parent().parent().parent().parent().find(".edit_task").hide()
    $(this).parent().parent().parent().parent().find(".workers").hide()
    $(this).parent().parent().parent().parent().find(".delete_task").hide()

  $(document).on "click", "#add_subtask", (event) ->
    $(this).parent().parent().parent().parent().find(".add_subtask").show()
    $(this).parent().parent().parent().parent().find(".all_subtasks").hide()
    $(this).parent().parent().parent().parent().find(".edit_task").hide()
    $(this).parent().parent().parent().parent().find(".workers").hide()
    $(this).parent().parent().parent().parent().find(".delete_task").hide()

  $(document).on "click", "#edit_task", (event) ->
    $(this).parent().parent().parent().parent().find(".add_subtask").hide()
    $(this).parent().parent().parent().parent().find(".all_subtasks").hide()
    $(this).parent().parent().parent().parent().find(".edit_task").show()
    $(this).parent().parent().parent().parent().find(".workers").hide()
    $(this).parent().parent().parent().parent().find(".delete_task").hide()

  $(document).on "click", "#workers", (event) ->
    $(this).parent().parent().parent().parent().find(".add_subtask").hide()
    $(this).parent().parent().parent().parent().find(".all_subtasks").hide()
    $(this).parent().parent().parent().parent().find(".edit_task").hide()
    $(this).parent().parent().parent().parent().find(".workers").show()
    $(this).parent().parent().parent().parent().find(".delete_task").hide()

  $(document).on "click", "#delete_task", (event) ->
    $(this).parent().parent().parent().parent().find(".add_subtask").hide()
    $(this).parent().parent().parent().parent().find(".all_subtasks").hide()
    $(this).parent().parent().parent().parent().find(".edit_task").hide()
    $(this).parent().parent().parent().parent().find(".workers").hide()
    $(this).parent().parent().parent().parent().find(".delete_task").show()

  $(document).ready ->
    $(".submit_edit_task").click ->
      modal = $(this).parent()
      model_hash = {}
      model_hash["title"] = modal.find("#title").val()
      model_hash["leader"] = modal.find("#person").val()

      task_div = modal.parent().parent().parent().parent().parent()
      task_div.find(".title").html(model_hash["title"])
      task_div.find(".task_leader").html(model_hash["leader"])

  $(document).ready ->
    $(".submit_add_task").click ->
      modal = $(this).parent()
      model_hash = {}
      model_hash["title"] = modal.find("#title").val()
      model_hash["leader"] = modal.find("#person").val()
      modal.parent().parent().parent().parent().modal("hide")
)()
