(->

  $(document).on "click", ".link_to_tasks", (event) ->
    if (event.target.toString().match("object HTMLTableCellElement") != null)
      href = $(this)[0].getAttribute("href")
      url = document.URL.split("/")
      taskURL = url.slice(0,(url.length - 1)).join("/")
      window.location = taskURL + href
    if (event.target.toString().match("object HTMLImageElement") != null)
      $(this).find("#task_template_modal").modal('show')

  $(document).on "click", "#edit_task_template", (event) ->
    $(this).parent().parent().parent().parent().find(".edit_task_template").show()
    $(this).parent().parent().parent().parent().find(".delete_task_template").hide()


  $(document).on "click", "#delete_task_template", (event) ->
    $(this).parent().parent().parent().parent().find(".edit_task_template").hide()
    $(this).parent().parent().parent().parent().find(".delete_task_template").show()

  $(document).ready ->
    $(".submit_edit_task_template").click ->
      modal = $(this).parent()
      model_hash = {}
      model_hash["title"] = modal.find("#title").val()
      model_hash["location"] = modal.find("#location").val()
      model_hash["created_by"] = modal.find("#created_by").val()
      model_hash["task_template_date"] = modal.find("#task_template_date").val()

      template_row_div = modal.parent().parent().parent().parent().parent().parent().parent()
      template_row_div.find(".template_title").html(model_hash["title"])
      template_row_div.find(".template_location").html(model_hash["location"])
      template_row_div.find(".template_created_by").html(model_hash["created_by"])
      template_row_div.find(".template_date").html(model_hash["task_template_date"])

)()
