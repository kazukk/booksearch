# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', -> # turbolinks対策
  ### ISBNコード入力フォーム：数値のみの入力 ###
  


  ### 書籍情報取得ボタン：Ajaxで情報取得 ###
  $('#info_search_button').click ->
    isbncode = $('#book_isbn').val()
    $.ajax
      async:    true
      url:      "/books/new/get_info/"
      type:     "GET"
      data:     {isbn: isbncode}
      dataType: "json"
      context:  this
      error: (jqXHR, textStatus, errorThrown) -> # 通信/サーバエラーなど
        $("#msg").css("color","#ff0000").html(errorThrown)
      success:  (data, textStatus, jqXHR) ->
        if data?
          $("#book_image").val(data.Image) # 画像
          $("#book_title").val(data.Title) # タイトル
          $("#book_author").val(data.Author) # 著者
          $("#book_manufacturer").val(data.Manufacturer) # 出版社
          $("#book_publication_date").val(data.Publication_Date) # 出版日
        else
          $("#msg").css("color","#ff0000").html("書籍情報が見つかりませんでした。")

  ### MSGのリセット ###
  $("#book_isbn").change -> $("#msg").html("")



