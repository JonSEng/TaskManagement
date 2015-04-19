# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(->
  $("input:checkbox[name='done_button']").parent().css "border-color", "green"  if $("input:checkbox[name='done_button']").is(":checked")
  $("input:checkbox[name='done_button']").change ->
    if $(this).is(":checked")
      $("input:checkbox[name='done_button']").parent().css "border-color", "green"
    else
      $("input:checkbox[name='done_button']").parent().css "border-color", "black"


  #Add worker popover. For a more general case, use [data-toggle="popover"] for the selector.
  $(".assign_worker_button").popover
    html: true
    content: ->
      $(this).parent().find(".assign_worker_div").html()

  # This hides other popovers when you open one.
  $(".assign_worker_button").click ->
    $(".assign_worker_button").not(this).popover "hide" #all but this


  #This hides a popover when you click outside of it.
  $("body").on "click", (e) ->
    $("[data-toggle=\"popover\"]").each ->
      $(this).popover "hide"  if not $(this).is(e.target) and $(this).has(e.target).length is 0 and $(".popover").has(e.target).length is 0

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
      task_div.find(".task_title").html(model_hash["title"])
      task_div.find(".task_leader").html(model_hash["leader"])

)()
