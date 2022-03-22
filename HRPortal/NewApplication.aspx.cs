﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var countries = nav.Countries.ToList();
                country.DataSource = countries;
                country.DataTextField = "Name";
                country.DataValueField = "Code";
                country.DataBind();
                country.Items.Insert(0, new ListItem("--select--", ""));

                countryRecruit.DataSource = countries;
                countryRecruit.DataTextField = "Name";
                countryRecruit.DataValueField = "Code";
                countryRecruit.DataBind();
                countryRecruit.Items.Insert(0, new ListItem("--select--", ""));

                HOAC.DataSource = countries;
                HOAC.DataTextField = "Name";
                HOAC.DataValueField = "Code";
                HOAC.DataBind();
                HOAC.Items.Insert(0, new ListItem("--select--", ""));

                HOAC.SelectedValue = "KE";
                


                var postC = nav.postcodes.ToList();
                postCode.DataSource = postC;
                postCode.DataTextField = "Code";
                postCode.DataValueField = "Code";
                postCode.DataBind();
                postCode.Items.Insert(0, new ListItem("--select--", ""));

                postalAddress.DataSource = postC;
                postalAddress.DataTextField = "Code";
                postalAddress.DataValueField = "Code";
                postalAddress.DataBind();
                postalAddress.Items.Insert(0, new ListItem("--select--", ""));

                var Countyz = nav.county.ToList();
                county.DataSource = Countyz;
                county.DataTextField = "Description";
                county.DataValueField = "Code";
                county.DataBind();
                county.Items.Insert(0, new ListItem("--select--", ""));

                
                var Qualifications = nav.Qualification.ToList();
                academic.DataSource = Qualifications;
                academic.DataTextField = "Description";
                academic.DataValueField = "Code";
                academic.DataBind();
                academic.Items.Insert(0, new ListItem("--select--", ""));


                //var Activities = nav.AgencyActivitiesSetup.ToList();
                //AgencyActivity.DataSource = Activities;
                //AgencyActivity.DataTextField = "Description";
                //AgencyActivity.DataValueField = "Code";
                //AgencyActivity.DataBind();
                //AgencyActivity.Items.Insert(0, new ListItem("--select--", ""));

                var Compliance = nav.AgencyComplianceSetup.ToList();
                certificateType.DataSource = Compliance;
                certificateType.DataTextField = "Description";
                certificateType.DataValueField = "Code";
                certificateType.DataBind();
                certificateType.Items.Insert(0, new ListItem("--select--", ""));

                var LicenseType = nav.LicenceTypeList.ToList();
                licenseType.DataSource = LicenseType;
                licenseType.DataTextField = "Description";
                licenseType.DataValueField = "Code";
                licenseType.DataBind();
                licenseType.Items.Insert(0, new ListItem("--select--", ""));

                email.Text = Convert.ToString(Session["email"]);


                string docNo = Request.QueryString["ApplicationNo"];
                if (docNo != null)
                {
                    var data = nav.LicenceApplicationHeader.Where(x => x.Application_No == docNo).ToList();
                    if (data.Count > 0)
                    {
                        editButton.Visible = true;
                        addapplication.Visible = false;
                        Nexttostep2.Visible = true;

                        foreach (var item in data)
                        {
                            licenseType.SelectedValue = item.Licence_Type;
                            string addresTyp = item.Physical_Address_Status;
                            string AppCategory = item.Application_Category;
                            string appType = item.Applicant_Type;                            
                            country.SelectedValue = item.Country_Region_Code;                           
                            PhysicalLocation.Text = item.Physical_Location;
                            certNo.Text = item.Registration_Certificate;
                            txtDateInc.Text = Convert.ToString(item.Registration_Date);
                            email.Text = item.Email;

                            hoaName.Text = item.HOA_Name;
                            HOAC.SelectedValue = item.HOA_Country;
                            string formCizizen = item.HOA_Form_of_Citizenship;
                            hoaId.Text = item.HOA_ID_NO;
                            hoaPass.Text = item.HOA_Passport_No;
                            HoaDesignation.Text = item.HOA_Designation;
                            HeadPhone.Text = item.HOA_Telephone_No;
                            hoaWhatsapp.Text = item.HOA_Whatsapp_No;
                            headEmail.Text = item.HOA_Email_Address;

                            if (addresTyp == "Owned")
                            {
                                addrresstype.SelectedValue = "1";
                            }
                            else if (addresTyp == "Leased")
                            {
                                addrresstype.SelectedValue = "2";
                            }

                            if (formCizizen == "Birth")
                            {
                                hoacitizen.SelectedValue = "1";
                            }
                            else if (formCizizen == "Naturalization")
                            {
                                hoacitizen.SelectedValue = "2";
                            }


                            Session["ApplicationNo"] = item.Application_No;







                        }
                    }
                }


            }
        }

        protected void addapplication_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                int txtresidence = 0;
                int txtapplicanttype = 0;
                int txtservicetype = 0;

                string tLicenceType = licenseType.SelectedValue.Trim();
                int tPhysicalAddressStatus = Convert.ToInt32(addrresstype.SelectedValue.Trim());
              
                string temail = email.Text.Trim();
                string txtcountry = country.SelectedValue;
                string ttPhysicalLocation = PhysicalLocation.Text.Trim();
                string tcertNo = certNo.Text.Trim();
                DateTime tIncorpDate = Convert.ToDateTime(txtDateInc.Text.Trim());
                string tCustomerNumber = Convert.ToString(Session["InstitutionNo"]);
                string thoaName = hoaName.Text.Trim();
                string tcountryCitizen = HOAC.SelectedValue.Trim();
                int tformCitizen = Convert.ToInt32(hoacitizen.SelectedValue.Trim());
                string thoaId = hoaId.Text.Trim();
                string thoaPass = hoaPass.Text.Trim();
                string tHoaDesignation = HoaDesignation.Text.Trim();
                string tHeadPhone = HeadPhone.Text.Trim();
                string thoaWhatsapp = hoaWhatsapp.Text.Trim();
                string theadEmail = headEmail.Text.Trim();



                DateTime txtstartdate = new DateTime();
               

                decimal txtfees = 0;


                if (error)
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string docNo = Convert.ToString(Session["ApplicationNo"]);
                    String status = Config.ObjNav.FnLicenceApplicationHeader(temail, docNo, ttPhysicalLocation, tPhysicalAddressStatus, tLicenceType, tCustomerNumber,tcertNo, 
                        tIncorpDate, thoaName, tcountryCitizen, tformCitizen, thoaId, thoaPass, tHoaDesignation, tHeadPhone, thoaWhatsapp, theadEmail);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["ApplicationNo"] = info[2];
                        Nexttostep2.Visible = true;
                        linesfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Nexttostep2_Click(object sender, EventArgs e)
        {
            string docNo = Convert.ToString(Session["ApplicationNo"]);
            Response.Redirect("NewApplication.aspx?step=2&&ApplicationNo="+docNo);
        }

        //protected void nexttostep3_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        bool error = false;
        //        string msg = "";
        //        string tpaymenttype = paymenttype.SelectedValue;
        //        string treferenceno = referenceno.Text.Trim();
        //        string nreturndate = returndate.Text.Trim();
        //        DateTime treturndate = new DateTime();
        //        try
        //        {
        //            treturndate = DateTime.ParseExact(nreturndate, "d/M/yyyy", CultureInfo.InvariantCulture);
        //        }
        //        catch (Exception)
        //        {
        //            error = true;
        //            msg += msg.Length > 0 ? "<br/>" : "";
        //            msg += "Please provide a transaction date";
        //        }
        //        if (!paymentdocument.HasFile)
        //        {
        //            error = true;
        //            msg += msg.Length > 0 ? "<br/>" : "";
        //            msg += "Please attach payment document to proceed";
        //        }
        //        if (error)
        //        {
        //            linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {
        //            string docNo = Convert.ToString(Session["ApplicationNo"]);
        //            String status = ""; /*Config.ObjNav.FnAddPaymentDetails(docNo, tpaymenttype, treturndate, treferenceno);*/
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                string accreditationNo = info[2];
        //                accreditationNo = accreditationNo.Replace('/', '_');
        //                accreditationNo = accreditationNo.Replace(':', '_');
        //                string path1 = Config.FilesLocation() + "Unprocessed Insitution/";
        //                string str1 = Convert.ToString(accreditationNo);
        //                string folderName = path1 + str1 + "/";
        //                try
        //                {
        //                    if (paymentdocument.HasFile)
        //                    {
        //                        string extension = System.IO.Path.GetExtension(paymentdocument.FileName);
        //                        if (extension == ".pdf" || extension == ".PDF" || extension == ".Pdf")
        //                        {
        //                            string filename = "PAYMENT_DOCUMENT" + extension;
        //                            if (!Directory.Exists(folderName))
        //                            {
        //                                Directory.CreateDirectory(folderName);
        //                            }
        //                            if (File.Exists(folderName + filename))
        //                            {
        //                                File.Delete(folderName + filename);
        //                            }
        //                            paymentdocument.SaveAs(folderName + filename);
        //                            if (File.Exists(folderName + filename))
        //                            {
        //                                String res = "";/*Config.ObjNav.FnAddPaymentDetails(docNo, tpaymenttype, treturndate, treferenceno);*/
        //                                String[] inf = res.Split('*');
        //                                if (inf[0] == "success")
        //                                {
        //                                    paymentfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                                }
        //                            }
        //                        }
        //                        else
        //                        {
        //                            error = true;
        //                            msg += msg.Length > 0 ? "<br>" : "";
        //                            msg += "The file extension of the payment document is not allowed,Kindly upload pdf files only";
        //                        }

        //                    }
        //                    else
        //                    {
        //                        error = true;
        //                        msg += msg.Length > 0 ? "<br>" : "";
        //                        msg += "The file extension of the payment document is not allowed,Kindly upload pdf files only";

        //                    }
        //                }
        //                catch (Exception ex)
        //                {
        //                    error = true;
        //                    msg += msg.Length > 0 ? "<br>" : "";
        //                    msg += "The file extension of the Application Letter is not allowed,Kindly upload pdf files only" + ex;
        //                }
        //            }
        //            else
        //            {
        //                paymentfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //    }
        //    catch (Exception m)
        //    {
        //        paymentfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //    Response.Redirect("NewApplication.aspx?step=3");
        //}


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string selectedActivities(List<Targets> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            string part = "";

            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<Targets>();
                }
                NewControl.ID = "feedback";
               
                foreach (Targets target in targetNumber)
                {

                    string InitiativeNumber = target.TargetNumber;
                    var nav1 = new Config().ReturnNav();
                
                    var status = Config.ObjNav.FnInsertAgencyActivities(target.ApplicationNo, target.TargetNumber);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[0];
                    }
                    else if (info[0] == "danger")
                    {

                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[1];


                    }


                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string selectedFacilities(List<Targets> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            string part = "";

            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<Targets>();
                }
                NewControl.ID = "feedback";

                foreach (Targets target in targetNumber)
                {

                    string InitiativeNumber = target.TargetNumber;
                    var nav1 = new Config().ReturnNav();

                    var status = Config.ObjNav.FnInsertAgentFacilities(target.ApplicationNo, target.TargetNumber, target.quantity, target.category);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[0];
                    }
                    else if (info[0] == "danger")
                    {

                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[1];


                    }


                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string selectedServices(List<Targets> targetNumber)
        {

            HtmlGenericControl NewControl = new HtmlGenericControl();
            var results = (dynamic)null;
            int category = 0;
            string part = "";

            try
            {
                if (targetNumber == null)
                {
                    targetNumber = new List<Targets>();
                }
                NewControl.ID = "feedback";

                foreach (Targets target in targetNumber)
                {

                    string InitiativeNumber = target.TargetNumber;
                    var nav1 = new Config().ReturnNav();

                    var status = Config.ObjNav.FnInsertAgentServices(target.ApplicationNo, target.TargetNumber, target.comment);
                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[0];
                    }
                    else if (info[0] == "danger")
                    {

                        NewControl.ID = "feedback";
                        NewControl.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        results = info[1];


                    }


                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertResponse(List<QuestionsModel> cmpitems)
        {
            string  tqnCode = "",  tresponse = "", tapplicationNo = "", tqnCategory = "";
           

            string results_0 = (dynamic)null;
           

            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<QuestionsModel>();

                //Loop and insert records.
                foreach (QuestionsModel oneitem in cmpitems)
                {
                    tqnCode = oneitem.QuestionCode;
                    tresponse = oneitem.response;
                    tapplicationNo = oneitem.applicationNo;
                    tqnCategory = oneitem.qnCategory;

                    if (string.IsNullOrWhiteSpace(tapplicationNo))
                    {
                        results_0 = "strengthnull";
                        return results_0;
                    }

                    string status = Config.ObjNav.FnInsertResponse(tapplicationNo, tqnCategory,tqnCode, tresponse);

                     string[] info = status.Split('*');
                    results_0 = info[0];                  


                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void backtostep1_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];          
            Response.Redirect("NewApplication.aspx?step=1&&applicationNo="+docNo);
        }
        protected void previousstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["ApplicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 - 1;
            Response.Redirect("NewApplication.aspx?ApplicationNo=" + str + "&step=" + num2);
        }
        protected void nextstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["ApplicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 + 1;
            Response.Redirect("NewApplication.aspx?ApplicationNo=" + str + "&step=" + num2);
        }

        protected void backtostep2_Click(object sender, EventArgs e)
        {
            Response.Redirect("NewApplication.aspx?step=2");
        }

        protected void submitapplicationtocue_Click(object sender, EventArgs e)
        {

        }

        protected void printreport_Click(object sender, EventArgs e)
        {
            string docNo = Convert.ToString(Session["ApplicationNo"]);
            Response.Redirect("ApplicationFinalReport.aspx?ApplicationNo=" +docNo);
        }

        protected void physicalAddressLocation_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                
                string tphysicalLocation = physicalLocationdetails.Text.Trim();               
                string tlocationAddress = locationAddress.Text.Trim();
                string tpostCode = postCode.SelectedValue.Trim();
                string tcounty = county.SelectedValue.Trim();
                string tcity = city.Text.Trim();
                string tApplicationNo = Request.QueryString["ApplicationNo"];



                DateTime txtstartdate = new DateTime();
                //try
                //{
                //    txtstartdate = DateTime.ParseExact(nstartdate, "d/M/yyyy", CultureInfo.InvariantCulture);
                //}
                // catch (Exception)
                //{
                //    error = true;
                //    msg += msg.Length > 0 ? "<br/>" : "";
                //    msg += "Please provide a valid start date";
                //}

                //DateTime txtenddate = new DateTime();
                //try
                //{
                //    txtenddate = DateTime.ParseExact(nenddate, "d/M/yyyy", CultureInfo.InvariantCulture);
                //}
                //catch (Exception)
                //{
                //    error = true;
                //    msg += msg.Length > 0 ? "<br/>" : "";
                //    msg += "Please provide a valid end date";
                //}

                decimal txtfees = 0;


                if (error)
                {
                    physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    
                    String status = Config.ObjNav.FnInsertLocation(tApplicationNo, tlocationAddress, tphysicalLocation, tpostCode, tcounty, tcity);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        nextBtn.Visible = true;
                        physicalLocations.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        //protected void Facility_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        bool error = false;
        //        string msg = "";

        //        string tfacilityCode = facilityDescription.SelectedValue.Trim();
        //        int tQuantity = Convert.ToInt32(quantity.Text.Trim());               
        //        string tApplicationNo = Request.QueryString["ApplicationNo"];                
               
        //        decimal txtfees = 0;


        //        if (error)
        //        {
        //            AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {

        //            String status = Config.ObjNav.FnInsertAgentFacilities(tApplicationNo, tfacilityCode, tQuantity,"");
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                AgencyFacilities.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //            else
        //            {
        //                AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //    }
        //    catch (Exception m)
        //    {
        //        AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        protected void backToPhysical_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("NewApplication.aspx?step=2&&applicationNo=" + docNo);
        }

        //protected void activity_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        bool error = false;
        //        string msg = "";

        //        string tAgencyActivity = AgencyActivity.SelectedValue.Trim();
        //        string tdescription = description.Text.Trim();
        //        string tApplicationNo = Request.QueryString["ApplicationNo"];

        //        decimal txtfees = 0;


        //        if (error)
        //        {
        //            AgencyActivitys.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {

        //            String status = Config.ObjNav.FnInsertAgencyActivities(tApplicationNo, tAgencyActivity);
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                AgencyActivitys.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //            else
        //            {
        //                AgencyActivitys.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //    }
        //    catch (Exception m)
        //    {
        //        AgencyActivitys.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        protected void backFacility_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("NewApplication.aspx?step=3&&applicationNo=" + docNo);
        }

        protected void BackActivity_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("NewApplication.aspx?step=4&&applicationNo=" + docNo);
        }

        protected void governement_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";

                string tcertificateType = certificateType.SelectedValue.Trim();
                string tcertificatenumber = certificatenumber.Text.Trim();
                DateTime tissueDate = Convert.ToDateTime(issueDate.Text.Trim());
                DateTime texpiryDate = Convert.ToDateTime(expiryDate.Text.Trim());
                string tAuthority = Authority.Text.Trim();
                string tApplicationNo = Request.QueryString["ApplicationNo"];

                decimal txtfees = 0;


                if (error)
                {
                    governemt.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertGovernmentCompliance(tApplicationNo, tcertificateType, tcertificateType, tcertificatenumber, tissueDate, texpiryDate, tAuthority);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        governemt.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        governemt.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                governemt.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void postCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postCode.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
                city2.Text = myCity.City;
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(entryNoRemove.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];              
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    physicalLocations.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveItem(mLineNo,ApplicationNo);
                    String[] info = status.Split('*');
                    physicalLocations.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

        protected void facilities_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(entryNoRemove.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveFacility(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    AgencyFacilities.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void staffButton_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                string tApplicationNo = Request.QueryString["ApplicationNo"];
                string tstaffName = staffName.Text.Trim();
                int tgender = Convert.ToInt32(gender.SelectedValue.Trim());
                string tNationality = nationality.Text.Trim();              
                string tiIdNumber = idnumber.Text.Trim();
                string tworkPermit = workPermit.Text.Trim();
                DateTime texpiryDate = Convert.ToDateTime(workExpiryDate.Text.Trim());
                string tgoodconduct = goodConduct.Text.Trim();
                string tAcademic = academic.SelectedValue.Trim();
                int tTerms = Convert.ToInt32(termsOfService.SelectedValue.Trim());


                decimal txtfees = 0;


                if (error)
                {
                    keyStaff.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertStaffMember(tApplicationNo, tstaffName, tgender, tNationality, tiIdNumber, tworkPermit, texpiryDate, tgoodconduct, tAcademic, tTerms);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        keyStaff.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        keyStaff.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                keyStaff.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void recruitButton_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                string tApplicationNo = Request.QueryString["ApplicationNo"];
                string tName = InstName.Text.Trim();                
                string tpostCode = postalAddress.SelectedValue.Trim();
                string tphysicalAddress = residentialAddress.Text.Trim();
                string tphysicalLocation = locationPhysical.Text.Trim();             
                string tcity = city2.Text.Trim();
                string tPhoneNumber = telephoneNo.Text.Trim();
                string tcountry = countryRecruit.SelectedValue.Trim();
                string temial = emailAddress.Text.Trim();
                int tAccredStatus = Convert.ToInt32(AccredStatus.SelectedValue.Trim());
                string tAccredBody = AccreditingBody.Text.Trim();


                decimal txtfees = 0;


                if (error)
                {
                    recruitingInst.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertRecruitmentInst(tApplicationNo, tName, tpostCode, tphysicalAddress, tphysicalLocation, tcity, tPhoneNumber, tcountry, temial, tAccredStatus, tAccredBody);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        recruitingInst.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        recruitingInst.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                recruitingInst.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void postalAddress_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postalAddress.SelectedValue);
            foreach (var myCity in cities)
            {
                
                city2.Text = myCity.City;
            }
        }

        protected void uploadDoc_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "License Application/";

            if (uploadfile.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(uploadfile.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string tDocCode = DocCode.Text.Trim();
                            DateTime tissueDate = Convert.ToDateTime(txtDate.Text.Trim());
                            DateTime tExpiryDate = Convert.ToDateTime(txtexpiry.Text.Trim());
                            String ApplicationNo = Request.QueryString["ApplicationNo"];
                            ApplicationNo = ApplicationNo.Replace('/', '_');
                            ApplicationNo = ApplicationNo.Replace(':', '_');
                            String documentDirectory = filesFolder + ApplicationNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + uploadfile.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    uploadfile.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {

                                        Config.navExtender.AddLinkToRecord("License_Application_Header", ApplicationNo, filename, "");
                                        var status =Config.ObjNav.FnAddDocumentsLinks(ApplicationNo, tDocCode,tissueDate,tExpiryDate);
                                        String[] info = status.Split('*');
                                        if (info[0] == "success")
                                        {
                                            documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }
                                        else
                                        {
                                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }
                                        
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }

        protected void submitApplication_Click(object sender, EventArgs e)
        {

            if (declaration.Checked == true)
            {

                try
                {
                    String tapplicationNo = Request.QueryString["ApplicationNo"];

                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tapplicationNo))
                    {
                        error = true;
                        message = "An application with the given applcationNo does not exist";
                    }

                    String status = Config.ObjNav.FnSubmitApplication(tapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        submitApplication.Visible = false;
                        previousSteps.Visible = false;
                        Payment.Visible = true;
                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        submitApplication.Visible = true;
                        previousSteps.Visible = true;
                        Payment.Visible = false;
                        submit.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    submit.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            else if (declaration.Checked == false)
            {

                var message = "Please accept our Terms and Conditions";
                submit.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "License Application/";
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                ApplicationNo = ApplicationNo.Replace('/', '_');
                ApplicationNo = ApplicationNo.Replace(':', '_');
                String documentDirectory = filesFolder + ApplicationNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }        


        }

        protected void Payment_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("Home_Payments.aspx?ApplicationNo=" + docNo);
        }

        protected void removeActivity_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(activityEntry.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    AgencyActivitys.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveActivity(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    AgencyActivitys.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                AgencyActivitys.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void EditG_Click(object sender, EventArgs e)
        {
            try
            {
                string tAuth = Auth.Text.Trim();
                string tcertNo = cerNo.Text;
                int tenrtyNo = Convert.ToInt32(govEntryNo.Text);
                DateTime tIssueDate = Convert.ToDateTime(issueDateG.Text);
                DateTime tExpiry = Convert.ToDateTime(ExpDate.Text);
                String applicationNo = Request.QueryString["ApplicationNo"];

                String status = Config.ObjNav.EditGovernanceCompliance(applicationNo, tenrtyNo, tAuth, tcertNo, tIssueDate, tExpiry);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    governemt.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    governemt.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                governemt.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void EditDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string taddres = modalAddress.Text.Trim();             
                string tphysical = modalPhysicalLoc.Text;
                int tenrtyNo = Convert.ToInt32(originalItemNo.Text);
                String applicationNo = Request.QueryString["ApplicationNo"];

                String status = Config.ObjNav.EditPhysicalLocation(applicationNo, tenrtyNo, taddres, tphysical);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    physicalLocations.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeG_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(governEntry.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    governemt.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveGovernance(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    governemt.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                governemt.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void EditstaffProf_Click(object sender, EventArgs e)
        {
            try
            {
                string tname = modalstaffName.Text.Trim();
                string tnationality = modalStaffNationality.Text;
                string tIdNo = modalIDPassp.Text;
                string tWorkPermit = modalWorkP.Text;
                string tgoodConduct = modalGoodCond.Text;
                int tenrtyNo = Convert.ToInt32(staffProfEntryNo.Text);
                String applicationNo = Request.QueryString["ApplicationNo"];

                String status = Config.ObjNav.EditStaffProfile(applicationNo, tenrtyNo, tname, tnationality, tIdNo, tWorkPermit, tgoodConduct);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    keyStaff.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    keyStaff.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                keyStaff.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removestaff_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(StaffEntry.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    keyStaff.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveStaff(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    keyStaff.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                keyStaff.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void unidelete_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(uniEntryDelete.Text.Trim());
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                int mNo = 0;
                Boolean error = false;
                try
                {
                    mNo = Convert.ToInt32(mLineNo);
                }
                catch (Exception)
                {
                    error = true;
                }
                if (error)
                {

                    recruitingInst.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveUniversity(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    recruitingInst.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                recruitingInst.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void HOAC_SelectedIndexChanged(object sender, EventArgs e)
        {
            string country = HOAC.SelectedValue.Trim();
            if (country != "KE")
            {
                local.Visible = false;
                foreign.Visible = true;
            }

        }
    }
}