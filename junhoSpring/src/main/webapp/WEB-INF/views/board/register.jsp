<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@include
file="../includes/header.jsp" %>
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-info">
      <div class="panel-heading">File Attach</div>
      <div class="panel-body">
        <div class="form-group uploadDiv">
          <input type="file" name="uploadFile" multiple />
        </div>
        <div class="form-group uploadResult">
          <ul></ul>
        </div>
      </div>
    </div>
  </div>
  <!-- col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">게시글 목록</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <form role="form" action="/board/register" method="post">
          <div class="form-group">
            <label>Title</label>
            <input class="form-control" name="title" />
          </div>
          <div class="form-group">
            <label>Content</label
            ><textarea class="form-control" rows="3" name="content"></textarea>
          </div>
          <div class="form-group">
            <label>Writer</label
            ><textarea class="form-control" name="writer"></textarea>
          </div>
          <button type="submit" class="btn btn-default">Submit</button>
          <button type="reset" class="btn btn-default">Reset</button>
        </form>
      </div>
      <!-- /.table-responsive -->
    </div>
    <!-- /.panel-body -->
  </div>
  <!-- /.panel -->
</div>
<!-- /.col-lg-6 -->
<!-- /.row -->

<%@include file="../includes/footer.jsp" %>
<script>
  function showImage(fileCallPath) {
    $(".bigPictureWrapper").css("display", "flex").show();
    $(".bigPicture")
      .html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
      .animate({ width: "100%", height: "100%" }, 1000);
    ///
    $(".bigPictureWrapper").on("click", function (e) {
      $(".bigPicture").animate({ width: "0%", height: "0%" }, 1000);
      setTimeout(function () {
        $(".bigPictureWrapper").hide();
      }, 1000);
    }); //bigPictureWrapper click
  }
  $(document).ready(function () {
    $("#regBtn").on("click", function () {
      self.location = "/board/register";
    });

    var formObj = $("form[role='form']");
    $("button[type='submit']").on("click", function (e) {
      e.preventDefault();
      console.log("submit clicked");

      let str = "";
      $(".uploadResult ul li").each(function (i, obj) {
        let jobj = $(obj);
        console.dir(jobj);
        str +=
          "<input type='hidden' name='attachList[" +
          i +
          "].fileName' value='" +
          jobj.data("filename") +
          "'>";
        str +=
          "<input type='hidden' name='attachList[" +
          i +
          "].uuid' value='" +
          jobj.data("uuid") +
          "'>";
        str +=
          "<input type='hidden' name='attachList[" +
          i +
          "].uploadPath' value='" +
          jobj.data("path") +
          "'>";
        str +=
          "<input type='hidden' name='attachList[" +
          i +
          "].fileType' value='" +
          jobj.data("type") +
          "'>";
      });
      formObj.append(str).submit();//submiy
    }); // submit button event
    $("input[type='file']").change(function (e) {
      console.log("file selected ........");
      var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
      var maxSize = 5242880;
      var cloneObj = $(".uploadDiv").clone();
      function checkExtension(fileName, fileSize) {
        if (fileSize >= maxSize) {
          alert("파일 크기 초과");
          return false;
        }
        if (regex.test(fileName)) {
          alert("해당 종류의 파일은 업로드 할 수 없음");
          return false;
        }
        return true;
      }

      var formData = new FormData();
      var inputFile = $("input[name='uploadFile']");
      var files = inputFile[0].files;
      console.log(files);

      for (var i = 0; i < files.length; i++) {
        if (!checkExtension(files[i].name, files[i].size)) {
          return false;
        }
        formData.append("uploadFile", files[i]);
      }
      console.log("files.lengh : " + files.length);
      $.ajax({
        url: "/uploadAjaxAction",
        processData: false,
        contentType: false,
        data: formData,
        type: "POST",
        dataType: "json",
        success: function (result) {
          console.log(result); /*  */
          showUploadedFile(result);
          $(".uploadDiv").html(cloneObj.html());
        },
      }); //ajax
      var uploadResult = $(".uploadResult ul");
      function showUploadedFile(uploadResultArr) {
        var str = "";
        $(uploadResultArr).each(function (i, obj) {
          if (!obj.fileType) {
            var fileCallPath = encodeURIComponent(
              obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName
            );
            str +=
              "<li data-path='" +
              obj.uploadPath +
              "' data-uuid='" +
              obj.uuid +
              "' data-filename='" +
              obj.fileName +
              "' data-type='" +
              obj.fileType +
              "'><div>";
            str += "<span>" + obj.fileName + "</span>";
            str +=
              "<button type='button' data-file='" +
              fileCallPath +
              "' data-type='file'  class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
            str += "<img src='/resources/images/attach.png'></a>";
            str += "</div></li>";
          } else {
            var fileCallPath = encodeURIComponent(
              obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName
            );
            str +=
              "<li data-path='" +
              obj.uploadPath +
              "' data-uuid='" +
              obj.uuid +
              "' data-filename='" +
              obj.fileName +
              "' data-type='" +
              obj.fileType +
              "'><div>";
            str += "<span>" + obj.fileName + "</span>";
            str +=
              "<button type='button' data-file='" +
              fileCallPath +
              "' data-type='image'  class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
            str += "<img src='/display?fileName=" + fileCallPath + "'>";
            str += "</div></li>";
          }
        });
        uploadResult.append(str);
      } //showUploadedFile
      $(".uploadResult").on("click", "button", function (e) {
        var targetFile = $(this).data("file");
        var type = $(this).data("type");
        var targetLi = $(this).closet("li");
        console.log(type);
        $.ajax({
          type: "post",
          url: { fileName: targetFile, type: type },
          data: {
            fileName: targetFile,
            type: type,
          },
          dataType: "text",
          success: function (result) {
            alert(result);
            targetLi.remove();
          },
        }); //$.ajax
      }); //event ends here
    }); //document
  });
</script>
