(->

  waitForFinalEventBuilder = () ->
    timers = {};
    return (callback, ms, uniqueId) ->
      if not uniqueId
        uniqueId = "Don't call this twice without a uniqueId";
      if timers[uniqueId]
        clearTimeout (timers[uniqueId]);
      timers[uniqueId] = setTimeout(callback, ms);
  waitForFinalEvent = waitForFinalEventBuilder()

  resizeTable = () ->
    $.each $(".task_lane"), () ->
      if $(this).find(".task_lane_contents").height() != null
        $(this).find(".task_lane_contents").height("auto")
        spaceAboveLane = parseInt($(this).css("top").toString().match(/\d+/g))
        spaceAboveLane += parseInt($(this).find("h4").css("line-height").toString().match(/\d+/g))
        spaceAboveLane += parseInt($(this).find("h4").css("margin-top").toString().match(/\d+/g))
        spaceAboveLane += parseInt($(this).css("padding-top").toString().match(/\d+/g))

        spaceBelowLane = $(this).find(".appendable").height()
        spaceBelowLane += parseInt($(this).css("margin-bottom").toString().match(/\d+/g))

        properHeight = $(document).height() - spaceAboveLane - spaceBelowLane

        $(this).find(".task_lane_contents").height(properHeight)

        if $(this).find(".task_lane_contents").get(0).scrollHeight != $(this).find(".task_lane_contents").get(0).clientHeight
          $(this).find(".task").width("auto")
          $(this).find(".task").width($(this).find(".task").width() - 5)

  $(document).ready ->
    resizeTable()

  $(window).resize( () ->
    waitForFinalEvent( () ->
      resizeTable()
    , 100, "resizing window");
  )

)()
