$(function () {

    $('#my_head_photo_container').imagesLoaded().done( function( instance ) {
        $('#my_head_photo_loading').hide();
        $('#my_head_photo').show();
    });

    $('#my_head_photo').on('load', function () {
        $('#my_head_photo_loading').hide();
        $(this).show();
    });

    $('#uploaded_photo').on('load', function(){
        $('#uploaded_photo_loading').hide();
        $(this).show();
        $('#progress-wrp').hide();
    });

    var myXhr = $.ajaxSettings.xhr();

    var Upload = function (file) {
        this.file = file;
    };

    Upload.prototype.getType = function() {
        return this.file.type;
    };
    Upload.prototype.getSize = function() {
        return this.file.size;
    };
    Upload.prototype.getName = function() {
        return this.file.name;
    };
    Upload.prototype.doUpload = function () {
        $('#progress-wrp').show();
        var $uploaded_photo = $('#uploaded_photo');
        $uploaded_photo.hide();
        $uploaded_photo.cropper('destroy');

        var that = this;
        var $form_submit_photo = $('#form_submit_photo');

        var formData = new FormData();

        // add assoc key values, this will be posts values
        formData.append("photo", this.file, this.getName());
        formData.append("upload_file", true);

        var csrfData = $form_submit_photo.serializeArray();
        formData.append(csrfData[0].name, csrfData[0].value);

        $.ajax({
            type: "POST",
            url: $form_submit_photo.attr("action"),
            xhr: function () {
                if (myXhr.upload) {
                    myXhr.upload.addEventListener('progress', that.progressHandling, false);
                    myXhr.upload.removeEventListener('loadend', that.loadendHandling, false);
                    myXhr.upload.addEventListener('loadend', that.loadendHandling, false);
                }
                return myXhr;
            },
            success: function (resp) {
                if (resp.error_message === "success"){
                    $('#uploaded_photo_loading').show();
                    var $uploaded_photo = $('#uploaded_photo');
                    var photo_url = resp.photo_url; // + '?' + new Date().getTime();
                    //$uploaded_photo.attr('src', photo_url);
                    $uploaded_photo.cropper({
                        aspectRatio: 1,
                        minContainerWidth: minImageWidth,
                        minContainerHeight: minImageHeight,
                        autoCropArea: 0.7,
                        zoomable: false,
                        crop: function (event) {
                            // Output the result data for cropping image.
                        }
                    });
                    $uploaded_photo.cropper('replace', photo_url);
                    $('#clip_photo_title').html("选择合适的区域作为头像");
                }
            },
            error: function (error) {
                // handle error
            },
            async: true,
            data: formData,
            dataType: "Json",
            cache: false,
            contentType: false,
            processData: false,
            timeout: 60000
        });
    };

    Upload.prototype.progressHandling = function (event) {
        var percent = 0;
        var position = event.loaded || event.position;
        var total = event.total;
        var progress_bar_id = "#progress-wrp";
        if (event.lengthComputable) {
            percent = Math.ceil(position / total * 100);
        }
        // update progressbars classes so it fits your code
        $(progress_bar_id + " .progress-bar").css("width", +percent + "%");
        $(progress_bar_id + " .status").text(percent + "%");
    };

    Upload.prototype.loadendHandling = function (event) {
        if (myXhr.upload) {
            myXhr.upload.removeEventListener('progress', this.progressHandling, false);
        }
    };

    $("#ingredient_file").on("change", function (e) {
        var file = $(this)[0].files[0];
        $(this).val("");
        var upload = new Upload(file);
        if (myXhr.upload){
            myXhr.upload.removeEventListener('progress', Upload.prototype.progressHandling, false);
            myXhr.abort();
        }

        $('#modal-info').modal('show');
        $('#clip_photo_title').html("图片上传中");

        // maby check size or type here with upload.getSize() and upload.getType()

        // execute upload
        upload.doUpload();
    });

    $('#upload_clippedphoto_btn').on("click", function (e) {
        $('#my_head_photo').hide();
        $('#my_head_photo_loading').show();
        $('#uploaded_photo').cropper('getCroppedCanvas').toBlob(function (blob) {
            var formData = new FormData();
            $form_upload_clippedphoto_btn = $('#form_upload_clippedphoto_btn');
            formData.append('photo', blob);

            var csrfData = $form_upload_clippedphoto_btn.serializeArray();
            formData.append(csrfData[0].name, csrfData[0].value);
            formData.append('photo_name', $('#uploaded_photo').attr('src'));

            $.ajax({
                method: "POST",
                data: formData,
                dataType: "Json",
                async: true,
                timeout: 60000,
                url: $form_upload_clippedphoto_btn.attr("action"),
                cache: false,
                processData: false,
                contentType: false,
                success: function (resp) {
                    if (resp.error_message === "success"){
                        var photo_url = resp.photo_url;// + '?' + new Date().getTime();
                        $my_head_photo = $('#my_head_photo');
                        $my_head_photo.attr('src', photo_url);
                    }
                },
                error: function () {
                    console.log('Upload error');
                }
            });
        });
    });
});