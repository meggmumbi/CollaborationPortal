$(document).ready(function () {

    var navListItems = $('div.setup-panel div a'),
        allWells = $('.setup-content'),
        allNextBtn = $('.nextBtn');

    allWells.hide();

    navListItems.click(function (e) {
        e.preventDefault();
        var $target = $($(this).attr('href')),
            $item = $(this);

        if (!$item.hasClass('disabled')) {
            navListItems.removeClass('btn-success').addClass('btn-default');
            $item.addClass('btn-success');
            allWells.hide();
            $target.show();
            $target.find('input:eq(0)').focus();
        }
    });

    allNextBtn.click(function () {
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
            curInputs = curStep.find("input[type='text'],input[type='url']"),
            isValid = true;

        $(".form-group").removeClass("has-error");
        for (var i = 0; i < curInputs.length; i++) {
            if (!curInputs[i].validity.valid) {
                isValid = false;
                $(curInputs[i]).closest(".form-group").addClass("has-error");
            }
        }

        if (isValid) nextStepWizard.removeAttr('disabled').trigger('click');
    });

    $('div.setup-panel div a.btn-success').trigger('click');



    $("#checkBoxAllGoods").change(function () {
        if (this.checked) {
            $(".worksselected").each(function () {
                this.checked = true;
            });
        } else {
            $(".worksselected").each(function () {
                this.checked = false;
            });
        }
    });
    var td2 = $(".selectedprequalificationsWorks")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });

    var PrimaryInitiative = new Array();
    $(".btn_apply_SubmitTargets").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".selectedprequalificationsWorks tr.active"), function () {
                //procurement category
                var checkbox_value = $('#worksselected').val();
                var Targets = {};
                Targets.targetNumber = ($(this).find('td').eq(1).text()); 
                Targets.ApplicationNo = $("#txtAppNo").val();
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
            Swal.fire({
                title: "Confirm Selected Activities?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"

            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "NewApplication.aspx/selectedActivities",
                        dataType: "json",
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.d;
                        console.log(JSON.stringify(registerstatus))
                        if (registerstatus == 'success') {
                            Swal.fire
                               ({
                                   title: "Activities Submitted!",
                                   text: "Your Agency Activities have been successfully submitted.Kindly Proceed!",
                                   type: "success"
                               }).then(() => {
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $('#feedback').attr("class", "alert alert-success");
                                   $("#feedback").html("Your Agency Activities have been successfully submitted.Kindly Proceed!");
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $("#feedback").html("Your Agency Activities have been successfully submitted.Kindly Proceed!");
                                   location.reload(true);
                               });
                        }

                        else {
                            Swal.fire
                                    ({
                                        title: "Activities submission Error!!!",
                                        text: registerstatus,
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html("Your Agency activities could not be submitted.Kindly select again and try to submit!" + registerstatus);
                                        location.reload(true);
                                    });

                        }
                        //switch (registerstatus) {
                        //    case "success":
                        //        Swal.fire
                        //        ({
                        //            title: "Examinations Submitted!",
                        //            text: "Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!",
                        //            type: "success"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $('#feedback').attr("class", "alert alert-success");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").reset();
                        //            location.reload(true);
                        //        });
                        //        PrimaryInitiative = [];
                        //        $('#plogsActivities').modal('hide');
                        //        $.modal.close();
                        //        document.location.reload();
                        //       // window.location("ExamBooking.aspx");
                        //        break;
                        //    default:
                        //        Swal.fire
                        //        ({
                        //            title: "feedback Error!!!",
                        //            text: registerstatus,
                        //            type: "error"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "red");
                        //            $('#feedback').addClass('alert alert-danger');
                        //            $("#feedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus);
                        //        });
                        //        PrimaryInitiative = [];
                        //        break;
                        //}
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                       'Submission Cancelled',
                            'You cancelled your Agency Activities submission details!',
                           'error'
                    );
                }
            });

        });





    $("#checkBoxAllGoods").change(function () {
        if (this.checked) {
            $(".FacilitySelected").each(function () {
                this.checked = true;
            });
        } else {
            $(".FacilitySelected").each(function () {
                this.checked = false;
            });
        }
    });
    var td2 = $(".tblselectedFacilities")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });

    var PrimaryInitiative = new Array();
    $(".btn_apply_SubmitFacilities").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".tblselectedFacilities tr.active"), function () {
                //procurement category
                var checkbox_value = $('#FacilitySelected').val();
                var Targets = {};
                Targets.quantity = ($(this).find("TD input").eq(1).val());
                Targets.targetNumber = ($(this).find('td').eq(1).text());
                Targets.capacity = ($(this).find("TD input").eq(2).val());
               // Targets.comment = ($(this).find("TD select").eq(0).val());
                Targets.specificDpt = ($(this).find("TD input").eq(3).val());
                Targets.shared = ($(this).find("TD input").eq(4).val());
                Targets.ApplicationNo = $("#txtAppNo").val();
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
            Swal.fire({
                title: "Confirm Selected Facilities?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"

            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "NewApplication.aspx/selectedFacilities",
                        dataType: "json",
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.d;
                        console.log(JSON.stringify(registerstatus))
                        if (registerstatus == 'success') {
                            Swal.fire
                               ({
                                   title: "Facilities Submitted!",
                                   text: "Your Agency Facilities have been successfully submitted.Kindly Proceed!",
                                   type: "success"
                               }).then(() => {
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $('#feedback').attr("class", "alert alert-success");
                                   $("#feedback").html("Your Agency Facilities have been successfully submitted.Kindly Proceed!");
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $("#feedback").html("Your Agency Facilities have been successfully submitted.Kindly Proceed!");
                                   location.reload(true);
                               });
                        }

                        else {
                            Swal.fire
                                    ({
                                        title: "Facilities submission Error!!!",
                                        text: registerstatus,
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html("Your Agency Facilities could not be submitted.Kindly select again and try to submit!" + registerstatus);
                                        location.reload(true);
                                    });

                        }
                        //switch (registerstatus) {
                        //    case "success":
                        //        Swal.fire
                        //        ({
                        //            title: "Examinations Submitted!",
                        //            text: "Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!",
                        //            type: "success"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $('#feedback').attr("class", "alert alert-success");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").reset();
                        //            location.reload(true);
                        //        });
                        //        PrimaryInitiative = [];
                        //        $('#plogsActivities').modal('hide');
                        //        $.modal.close();
                        //        document.location.reload();
                        //       // window.location("ExamBooking.aspx");
                        //        break;
                        //    default:
                        //        Swal.fire
                        //        ({
                        //            title: "feedback Error!!!",
                        //            text: registerstatus,
                        //            type: "error"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "red");
                        //            $('#feedback').addClass('alert alert-danger');
                        //            $("#feedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus);
                        //        });
                        //        PrimaryInitiative = [];
                        //        break;
                        //}
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                       'Submission Cancelled',
                            'You cancelled your Agency Facilities submission details!',
                           'error'
                    );
                }
            });

        });


    $("#checkBoxAllGoods").change(function () {
        if (this.checked) {
            $(".servicesSelected").each(function () {
                this.checked = true;
            });
        } else {
            $(".servicesSelected").each(function () {
                this.checked = false;
            });
        }
    });
    var td2 = $(".tblselectedServices")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });

    var PrimaryInitiative = new Array();
    $(".btn_apply_SubmitServices").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".tblselectedServices tr.active"), function () {
                //procurement category
                var checkbox_value = $('#EquipmentSelected').val();
                var Targets = {};
                Targets.category = ($(this).find("TD input").eq(1).val());
                Targets.quantity = ($(this).find("TD input").eq(2).val());
                Targets.targetNumber = ($(this).find('td').eq(1).text());
                Targets.capacity = ($(this).find("TD input").eq(3).val());
                //Targets.comment = ($(this).find("TD select").eq(0).val());
                Targets.specificDpt = ($(this).find("TD input").eq(4).val());
                Targets.shared = ($(this).find("TD input").eq(5).val());
                Targets.ApplicationNo = $("#txtAppNo").val();
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
            Swal.fire({
                title: "Confirm Selected Equipment and teaching materials?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"

            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "NewApplication.aspx/selectedServices",
                        dataType: "json",
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.d;
                        console.log(JSON.stringify(registerstatus))
                        if (registerstatus == 'success') {
                            Swal.fire
                               ({
                                   title: "Details Submitted!",
                                   text: "Your Equipment and teaching materials Details have been addded.Kindly Proceed!",
                                   type: "success"
                               }).then(() => {
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $('#feedback').attr("class", "alert alert-success");
                                   $("#feedback").html("Your Equipment and teaching materials Details have been addded.Kindly Proceed!");
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $("#feedback").html("Your Equipment and teaching materials Details have been addded.Kindly Proceed!");
                                   location.reload(true);
                               });
                        }

                        else {
                            Swal.fire
                                    ({
                                        title: " Equipment and teaching materials submission Error!!!",
                                        text: registerstatus,
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html("Your Equipment and teaching materials could not be submitted.Kindly select again and try to submit!" + registerstatus);
                                        location.reload(true);
                                    });

                        }
                        //switch (registerstatus) {
                        //    case "success":
                        //        Swal.fire
                        //        ({
                        //            title: "Examinations Submitted!",
                        //            text: "Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!",
                        //            type: "success"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $('#feedback').attr("class", "alert alert-success");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "green");
                        //            $("#feedback").html("Your Examination papers have been successfully submitted.Kindly Proceed to select an examination center in the next step details!");
                        //            $("#feedback").reset();
                        //            location.reload(true);
                        //        });
                        //        PrimaryInitiative = [];
                        //        $('#plogsActivities').modal('hide');
                        //        $.modal.close();
                        //        document.location.reload();
                        //       // window.location("ExamBooking.aspx");
                        //        break;
                        //    default:
                        //        Swal.fire
                        //        ({
                        //            title: "feedback Error!!!",
                        //            text: registerstatus,
                        //            type: "error"
                        //        }).then(() => {
                        //            $("#feedback").css("display", "block");
                        //            $("#feedback").css("color", "red");
                        //            $('#feedback').addClass('alert alert-danger');
                        //            $("#feedback").html("Your Examination papers could not be submitted.Kindly select again and try to submit!" + registerstatus);
                        //        });
                        //        PrimaryInitiative = [];
                        //        break;
                        //}
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                       'Submission Cancelled',
                            'You cancelled your Equipment and teaching materials submission details!',
                           'error'
                    );
                }
            });

        });


    $("#checkBoxAllGoods").change(function () {
        if (this.checked) {
            $(".FacilitySelected").each(function () {
                this.checked = true;
            });
        } else {
            $(".FacilitySelected").each(function () {
                this.checked = false;
            });
        }
    });
    var td2 = $(".tblselectedFacilities")
    td2.on("change",
        "tbody tr .checkboxes",
        function () {
            var t = jQuery(this).is(":checked"), selected_arr = [];
            t ? ($(this).prop("checked", !0), $(this).parents("tr").addClass("active"))
                : ($(this).prop("checked", !1), $(this).parents("tr").removeClass("active"));
            // Read all checked checkboxes
            $("input:checkbox[class=checkboxes]:checked").each(function () {
                selected_arr.push($(this).val());
            });

            if (selected_arr.length > 0) {
                $("#rfiresponsefeedback").css("display", "block");

            } else {
                $("#rfiresponsefeedback").css("display", "none");
                selected_arr = [];
            }

        });

    var PrimaryInitiative = new Array();
    $(".btn_apply_SubmitRenewalFacilities").on("click",
        function (e) {
            e.preventDefault();
            PrimaryInitiative = [];
            $.each($(".tblselectedFacilities tr.active"), function () {
                //procurement category
                var checkbox_value = $('#FacilitySelected').val();
                var Targets = {}; 
                Targets.quantity = ($(this).find("TD input").eq(1).val());
                Targets.adequacy = ($(this).find("TD input").eq(2).val());
                Targets.targetNumber = ($(this).find('td').eq(1).text());
                Targets.category = ($(this).find('td').eq(2).text());
                Targets.ApplicationNo = $("#txtAppNo").val();
                PrimaryInitiative.push(Targets);
            });
            var postData = {
                catgeories: PrimaryInitiative
            };
            console.log(JSON.stringify(PrimaryInitiative))
            Swal.fire({
                title: "Confirm Selected Facilities?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"

            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: '{targetNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                        url: "LicenseRenewal.aspx/selectedFacilities",
                        dataType: "json",
                        processData: false
                    }).done(function (status) {
                        var registerstatus = status.d;
                        console.log(JSON.stringify(registerstatus))
                        if (registerstatus == 'success') {
                            Swal.fire
                               ({
                                   title: "Facilities Submitted!",
                                   text: "Your Agency Facilities have been successfully submitted.Kindly Proceed!",
                                   type: "success"
                               }).then(() => {
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $('#feedback').attr("class", "alert alert-success");
                                   $("#feedback").html("Your Agency Facilities have been successfully submitted.Kindly Proceed!");
                                   $("#feedback").css("display", "block");
                                   $("#feedback").css("color", "green");
                                   $("#feedback").html("Your Agency Facilities have been successfully submitted.Kindly Proceed!");
                                   location.reload(true);
                               });
                        }

                        else {
                            Swal.fire
                                    ({
                                        title: "Facilities submission Error!!!",
                                        text: registerstatus,
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html("Your Agency Facilities could not be submitted.Kindly select again and try to submit!" + registerstatus);
                                        location.reload(true);
                                    });

                        }
                      
                    }
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                       'Submission Cancelled',
                            'You cancelled your Agency Facilities submission details!',
                           'error'
                    );
                }
            });

        });


    $(".btn_request_assistance").click(function () {
        var tuseremailaddress = $("#useremailaddress").val();
        var tcueemailaddress = $("#cueemailaddress").val();
        var temailsubject = $("#emailsubject").val();
        var temailassistance = $("#emailassitancerequest").val();
        if (tuseremailaddress != '' && tcueemailaddress != '' && temailsubject != '' && temailassistance != '') {
            console.log(JSON.stringify(temailassistance))
            //Swal Message
            Swal.fire({
                title: "Confirm  Assitance Request?",
                text: "Are you sure you would like to proceed with submission?",
                type: "warning",
                showCancelButton: true,
                closeOnConfirm: true,
                confirmButtonText: "Yes, Proceed!",
                confirmButtonClass: "btn-success",
                confirmButtonColor: "#008000",
                position: "center"
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: "POST",
                        url: "ICTHelpDesk.aspx/AssitanceRequest",
                        data: "{'tuseremailaddress':'" + tuseremailaddress + "','tcueemailaddress':'" + tcueemailaddress + "','temailsubject':'" + temailsubject + "','temailassistance':'" + temailassistance + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (status) {
                            switch (status.d) {
                                case "success":
                                    swal({
                                        title: "Assistance Request Submitted!",
                                        text: "Your Assistance Reqeuest was Successfully Sent.Kindly Check your Email Account for More Information.",
                                        icon: "success",
                                        type: "success"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "green");
                                        $('#feedback').attr("class", "alert alert-success");
                                        $("#feedback").html("Your Assistance Reqeuest was Successfully Sent.Kindly Check your Email Account for More Information!");
                                    });
                                    break;
                                default:
                                    swal({
                                        title: "Assitance Request Error!!!",
                                        text: "Error Occured whenSubmitting your Assitance Request.Kindly Try Again or Contact CUE for More Information",
                                        type: "error"
                                    }).then(() => {
                                        $("#feedback").css("display", "block");
                                        $("#feedback").css("color", "red");
                                        $('#feedback').addClass('alert alert-danger');
                                        $("#feedback").html(status.d);
                                    });
                                    break;
                            }
                        }
                    })
                }
                else if (result.dismiss === Swal.DismissReason.cancel) {
                    Swal.fire(
                        'Assistance Request Cancelled',
                        'You cancelled your Assistance Request submission details!',
                        'error'
                    );
                }

            });
        }
        else {
            Swal.fire({
                icon: 'error',
                type: 'error',
                title: 'Oops...',
                text: 'Fill in all the Details before you submit your Request!',
                footer: '<a href>Contact CUE for Any Clarifications!!</a>'
            })
        }
    });

});