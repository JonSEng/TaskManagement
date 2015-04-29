(->

  $(document).on "click", ".link_to_tasks", (event) ->
    if (event.target.toString().match("object HTMLTableCellElement") != null)
      href = $(this)[0].getAttribute("href")
      url = document.URL.split("/")
      taskURL = url.slice(0,(url.length - 1)).join("/")
      window.location = taskURL + href
    if (event.target.toString().match("object HTMLImageElement") != null)
      $(this).find("#task_session_modal").modal('show')

  $(document).on "click", "#edit_task_session", (event) ->
    $(this).parent().parent().parent().parent().find(".edit_task_session").show()
    $(this).parent().parent().parent().parent().find(".delete_task_session").hide()


  $(document).on "click", "#delete_task_session", (event) ->
    $(this).parent().parent().parent().parent().find(".edit_task_session").hide()
    $(this).parent().parent().parent().parent().find(".delete_task_session").show()


  $(document).ready ->
    $(".submit_edit_task_session").click ->
      modal = $(this).parent().parent()
      model_hash = {}
      model_hash["title"] = modal.find("#title").val()
      model_hash["location"] = modal.find("#location").val()
      model_hash["admin"] = modal.find("#admin").val()
      model_hash["task_session_date"] = modal.find("#task_session_date").val()

      if (model_hash["task_session_date"].split("-").length == 3)
        date_array = model_hash["task_session_date"].split("-")
        year = parseInt(date_array[0], 10)
        month = parseInt(date_array[1], 10)
        day = parseInt(date_array[2], 10)

        valid = day > 0 and month > 0 and year > 0
        if (year % 4 == 0 and month == 2)
          valid &= (month == 2 and day < 30)
        else if (month == 2)
          valid &= day < 29
        else if (month in [4, 6, 9, 11])
          valid &= day < 31
        else
          valid &= day < 32
        valid &= month < 13

        if (!valid)
          alert("Date Invalid.");
        else
          session_row_div = modal.parent().parent().parent().parent().parent().parent().parent()
          session_row_div.find(".session_title").html(model_hash["title"])
          session_row_div.find(".session_location").html(model_hash["location"])
          session_row_div.find(".session_admin").html(model_hash["admin"])
          session_row_div.find(".session_date").html(model_hash["task_session_date"])
)()
