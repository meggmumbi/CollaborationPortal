using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class LicenseRenewal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var countries = nav.Countries.ToList();
                foreignCountry.DataSource = countries;
                foreignCountry.DataTextField = "Name";
                foreignCountry.DataValueField = "Code";
                foreignCountry.DataBind();
                foreignCountry.Items.Insert(0, new ListItem("--select--", ""));



                var postC = nav.postcodes.ToList();

                PostCode.DataSource = postC;
                PostCode.DataTextField = "Code";
                PostCode.DataValueField = "Code";
                PostCode.DataBind();
                PostCode.Items.Insert(0, new ListItem("--select--", ""));

                var Paymodes = nav.PaymentModesSetup;
                PaymentModes.DataSource = Paymodes;
                PaymentModes.DataTextField = "Code";
                PaymentModes.DataValueField = "Code";
                PaymentModes.DataBind();
                PaymentModes.Items.Insert(0, new ListItem("--select--", ""));


                var Qualifications = nav.Qualification.Where(x => x.Qualification_Category == "Academic").ToList();
                academic.DataSource = Qualifications;
                academic.DataTextField = "Description";
                academic.DataValueField = "Code";
                academic.DataBind();
                academic.Items.Insert(0, new ListItem("--select--", ""));


                AcademicQualification.DataSource = Qualifications;
                AcademicQualification.DataTextField = "Description";
                AcademicQualification.DataValueField = "Code";
                AcademicQualification.DataBind();
                AcademicQualification.Items.Insert(0, new ListItem("--select--", ""));


                emailAddrelocal.Text = Convert.ToString(Session["email"]);
                string institution = Convert.ToString(Session["InstitutionNo"]);
                var contacts = nav.Contacts.Where(r => r.No == institution).ToList();
                if (contacts.Count > 0)
                {
                    foreach (var contact in contacts)
                    {
                        NameCollab.Text = contact.Name;
                        PhysicalLocation.Text = contact.Address;
                        PostCode.SelectedValue = contact.Post_Code;
                        localCity.Text = contact.City;
                        postaLAddressPoBox.Text = contact.Address_2;
                        telephoneNoLocal.Text = contact.Phone_No;
                        website.Text = contact.Home_Page;

                    }



                }






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
                            //Local
                            NameCollab.Text = item.Name_of_Applying_Institution;
                            PhysicalLocation.Text = item.Physical_Location;
                            PostCode.SelectedValue = item.Post_Code;
                            localCity.Text = item.City;
                            postaLAddressPoBox.Text = item.Address;
                            telephoneNoLocal.Text = item.Phone_No;
                            website.Text = item.Website;
                            accreditingBodyLocal.Text = item.Local_Uni_Accrediting_Body;
                            CapitalBudget.Text = Convert.ToString(item.Capital_in_Kshs);
                            recurrentBudget.Text = Convert.ToString(item.Recurrent_in_Ksh);
                            LocalAcademic.Text = item.Local_Academic_Focus;
                            localPrinciple.Text = item.Local_Research_Focus;
                            benefit.Text = item.Benefit_of_the_collaboration;
                            ProgrammeNameOff.Text = item.Name_of_the_Programme_offered;
                            ApllicationAmount.Text = Convert.ToString(item.Application_Amount);
                            AcademicQualification.SelectedValue = item.Qualification_Type;
                            studentRation.Text = item.Student_Staff_ratio;
                            staffLoad.Text = item.Staff_Teaching_Load_per_Prog;

                            string ApplicantType1 = item.Type_of_Apply_Institution;

                            if (ApplicantType1 == "Kenyan")
                            {
                                applicantType.SelectedValue = "1";
                            }
                            else if (ApplicantType1 == "Foreign")
                            {
                                applicantType.SelectedValue = "2";
                            }
                            else
                            {
                                applicantType.SelectedValue = "0";
                            }

                            string AccreditingLocalStatus = item.Local_Accreditation_Status;
                            if (AccreditingLocalStatus == "Accredited")
                            {
                                AcrreditationStatusLocal.SelectedValue = "1";
                            }
                            else
                            {
                                AcrreditationStatusLocal.SelectedValue = "0";
                            }

                            //Foreign
                            foreignInst.Text = item.Name_of_Foreign_University;
                            foreignCountry.SelectedValue = item.Foreign_University_Country;
                            postalAddressF.Text = item.Postal_Address;
                            physicalAddressF.Text = item.Physical_Address;
                            telephoneNumberF.Text = item.Telephone_No;
                            foreignEmail.Text = item.Email_Address;
                            websiteF.Text = item.Web_site;
                            accreditingForeign.Text = item.Foreign_Uni_Accrediting_Body;
                            ForeignAcademic.Text = item.Primary_Academic_Focus;
                            ForeignResearch.Text = item.Principal_Research_Focus;

                            string accreditingStatusForeign = item.Accreditation_Status;

                            if (accreditingStatusForeign == "Accredited")
                            {
                                acreeditationStatusForeign.SelectedValue = "1";
                            }
                            else
                            {
                                acreeditationStatusForeign.SelectedValue = "0";
                            }

                            if (item.Name_of_Foreign_University != "")
                            {
                                ForeignDetails.Visible = true;
                                foreignDetailz.Visible = false;
                            }
                            if (item.paymentReference != "")
                            {
                                previewReport.Visible = true;
                                evidencePayment.Visible = false;
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

                //Local
                string LName = NameCollab.Text.Trim();
                string lPhysicalLocation = PhysicalLocation.Text.Trim();
                string lPostCode = PostCode.SelectedValue.Trim();
                string llocalCity = localCity.Text.Trim();
                string LpostaLAddressPoBox = postaLAddressPoBox.Text.Trim();
                string LtelephoneNoLocal = telephoneNoLocal.Text.Trim();
                string LemailAddrelocal = emailAddrelocal.Text.Trim();
                string lwebsite = website.Text.Trim();
                int LAcrreditationStatusLocal = Convert.ToInt32(AcrreditationStatusLocal.SelectedValue.Trim());
                string LaccreditingBodyLocal = accreditingBodyLocal.Text;
                string tLocalAcademic = LocalAcademic.Text;
                string tlocalPrinciple = localPrinciple.Text;
                string tprogramme = ProgrammeNameOff.Text;
                decimal trecurrent = Convert.ToDecimal(recurrentBudget.Text);
                decimal Tcapital = Convert.ToDecimal(CapitalBudget.Text);
                string tstudentRation = studentRation.Text.Trim();
                string tstaffLoad = staffLoad.Text.Trim();
                string tQualification = AcademicQualification.SelectedValue.Trim();
                string intstitutionNo = Convert.ToString(Session["InstitutionNo"]);
                int ApplicantType = Convert.ToInt32(applicantType.SelectedValue);
                string tbenefit = benefit.Text;




                DateTime txtstartdate = new DateTime();


                decimal txtfees = 0;


                if (error)
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string docNo = Convert.ToString(Session["ApplicationNo"]);
                    String status = Config.ObjNav.FnCollabApplicationHeader(LName, docNo, lPhysicalLocation, lPostCode, llocalCity, LpostaLAddressPoBox, LtelephoneNoLocal,
                       LemailAddrelocal, lwebsite, LAcrreditationStatusLocal, LaccreditingBodyLocal, tlocalPrinciple, intstitutionNo, trecurrent, Tcapital, ApplicantType);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["ApplicationNo"] = info[2];
                        Nexttostep2.Visible = true;

                        String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Collaboration Application/";

                        if (uploadfile.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filesFolder))
                                {
                                    String extension = System.IO.Path.GetExtension(uploadfile.FileName);
                                    if (new Config().IsAllowedExtension(extension))
                                    {

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
                                            linesfeedback.InnerHtml =
                                                                            "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                        }
                                        if (createDirectory)
                                        {
                                            string filename = documentDirectory + uploadfile.FileName;
                                            if (File.Exists(filename))
                                            {
                                                linesfeedback.InnerHtml =
                                                                                   "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                            }
                                            else
                                            {
                                                uploadfile.SaveAs(filename);
                                                if (File.Exists(filename))
                                                {

                                                    Config.navExtender.AddLinkToRecord("Collaboration Card", ApplicationNo, filename, "");
                                                    // var status1 = Config.ObjNav.FnAddDocumentsLinks(ApplicationNo, tDocCode);
                                                    // String[] info1 = status1.Split('*');
                                                    //if (info1[0] == "success")
                                                    //{
                                                    //    linesfeedback.InnerHtml =
                                                    //    "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                    //}
                                                    //else
                                                    //{
                                                    //    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + info1[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                    //}

                                                }
                                                else
                                                {
                                                    linesfeedback.InnerHtml =
                                                        "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        linesfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                                else
                                {
                                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            catch (Exception ex)
                            {
                                linesfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                        }
                        else
                        {
                            linesfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        }


                        linesfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        Response.Redirect("LicenseRenewal.aspx?step=2&&ApplicationNo=" + info[2]);
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
            Response.Redirect("NewApplication.aspx?step=2&&ApplicationNo=" + docNo);
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

                    var status = Config.ObjNav.FnInsertAgentFacilities(target.ApplicationNo, target.TargetNumber, Convert.ToInt32(target.quantity), target.capacity, Convert.ToInt32(target.specificDpt), Convert.ToInt32(target.shared));
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

                    var status = Config.ObjNav.FnInsertEquipments(target.ApplicationNo, target.TargetNumber, Convert.ToInt32(target.quantity), target.capacity, target.category,0,0);
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
            string tqnCode = "", tresponse = "", tapplicationNo = "", tqnCategory = "";


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

                    string status = Config.ObjNav.FnInsertResponse(tapplicationNo, tqnCategory, tqnCode, tresponse);

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
            Response.Redirect("NewApplication.aspx?step=1&&applicationNo=" + docNo);
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
            Response.Redirect("ApplicationFinalReport.aspx?ApplicationNo=" + docNo);
        }

        protected void physicalAddressLocation_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    bool error = false;
            //    string msg = "";

            //string tphysicalLocation = physicalLocationdetails.Text.Trim();               
            //string tlocationAddress = locationAddress.Text.Trim();
            //string tpostCode = postCode.SelectedValue.Trim();
            //string tcounty = county.SelectedValue.Trim();
            //string tcity = city.Text.Trim();
            //string tApplicationNo = Request.QueryString["ApplicationNo"];
            //int tLocationtType = Convert.ToInt32(locationType.SelectedValue);



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

            //    decimal txtfees = 0;


            //    if (error)
            //    {
            //        physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }
            //    else
            //    {

            //        String status = Config.ObjNav.FnInsertLocation(tApplicationNo, tlocationAddress, tphysicalLocation, tpostCode, tcounty, tcity, tLocationtType);
            //        String[] info = status.Split('*');
            //        if (info[0] == "success")
            //        {
            //            nextBtn.Visible = true;
            //            locationType.SelectedValue = "0";
            //            locationAddress.Text = "";
            //            physicalLocationdetails.Text = "";
            //            postCode.SelectedValue = "";
            //            county.SelectedValue = "";
            //            city.Text = "";
            //            physicalLocations.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //        else
            //        {
            //            physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }
            //}
            //catch (Exception m)
            //{
            //    physicalLocations.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
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
                    String status = Config.ObjNav.RemoveItem(mLineNo, ApplicationNo);
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
                DateTime texpiryDate = new DateTime();
                string tApplicationNo = Request.QueryString["ApplicationNo"];
                string tstaffName = staffName.Text.Trim();
                int tgender = Convert.ToInt32(gender.SelectedValue.Trim());
                string trank = rank.Text.Trim();
                string tAcademic = academic.SelectedValue.Trim();
                string tqualificationText = qualificationText.Text.Trim();
                string tAreaSpecialization = AreaSpecialization.Text.Trim();
                DateTime tgradDate = Convert.ToDateTime(gradDate.Text.Trim());
                int texperience = Convert.ToInt32(experience.Text.Trim());
                string tremarksStaff = remarksStaff.Text.Trim();
                string tinstStudies = instStudies.Text.Trim();

                int tTerms = Convert.ToInt32(termsOfService.SelectedValue.Trim());





                decimal txtfees = 0;


                if (error)
                {
                    keyStaff.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertStaffMember(tApplicationNo, tstaffName, tgender, trank, tAcademic, tqualificationText, tAreaSpecialization, tgradDate, texperience, tremarksStaff, tTerms, tinstStudies);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        instStudies.Text = "";
                        staffName.Text = "";
                        rank.Text = "";
                        gender.SelectedValue = "0";
                        qualificationText.Text = "";
                        AreaSpecialization.Text = "";
                        gradDate.Text = "";
                        experience.Text = "";
                        remarksStaff.Text = "";
                        academic.SelectedValue = "";
                        termsOfService.SelectedValue = "0";
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





        protected void uploadDoc_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Collaboration Application/";

            if (uploadfile.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(uploadfile.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string tDocCode = ModalDocCode.Text.Trim();

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
                                string filename = documentDirectory + uploadfile.FileName + "_" + tDocCode;
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

                                        Config.navExtender.AddLinkToRecord("Collaboration Card", ApplicationNo, filename, "");
                                        var status = Config.ObjNav.FnAddDocumentsLinks(ApplicationNo, tDocCode, filename);
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

                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('StatusOfApplication.aspx') }, 5000);", true);
                    }
                    else
                    {
                        submitApplication.Visible = true;
                        previousSteps.Visible = true;

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

                    sources.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.RemoveActivity(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    sources.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                sources.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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


        protected void EditstaffProf_Click(object sender, EventArgs e)
        {
            try
            {
                string tname = modalstaffName.Text.Trim();
                string trank = modalStaffNationality.Text;
                string Tqualification = modalIDPassp.Text;
                string tAreaofSpecialization = modalWorkP.Text;
                string Tinstitution = modalGoodCond.Text;
                int tenrtyNo = Convert.ToInt32(staffProfEntryNo.Text);
                String applicationNo = Request.QueryString["ApplicationNo"];

                String status = Config.ObjNav.EditStaffProfile(applicationNo, tenrtyNo, tname, trank, Tqualification, tAreaofSpecialization, Tinstitution);
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



        protected void previewReport_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("ApplicationFinalReport.aspx?ApplicationNo=" + docNo);
        }

        protected void previousSteps_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("ApplicationFinalReport.aspx?ApplicationNo=" + docNo);
        }

        protected void docDelete_Click(object sender, EventArgs e)
        {
            try

            {

                int mLineNo = Convert.ToInt32(docEntry.Text.Trim());
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

                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The line no could not be found<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    String status = Config.ObjNav.Removedoc(mLineNo, ApplicationNo);
                    String[] info = status.Split('*');
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void ForeignDetails_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                int txtresidence = 0;
                int txtapplicanttype = 0;
                int txtservicetype = 0;



                string FName = foreignInst.Text.Trim();
                string FPhysicalLocation = physicalAddressF.Text.Trim();
                string FforeignCountry = foreignCountry.SelectedValue.Trim();
                string FpostaLAddressPoBox = postalAddressF.Text.Trim();
                string FtelephoneNoLocal = telephoneNumberF.Text.Trim();
                string FemailAddrelocal = foreignEmail.Text.Trim();
                string Fwebsite = websiteF.Text.Trim();
                int FacreeditationStatusForeign = Convert.ToInt32(acreeditationStatusForeign.SelectedValue.Trim());
                string FaccreditingForeign = accreditingForeign.Text;
                string tForeignAcademic = ForeignAcademic.Text;
                string TForeignResearch = ForeignResearch.Text;




                DateTime txtstartdate = new DateTime();


                decimal txtfees = 0;


                if (error)
                {
                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    string docNo = Convert.ToString(Session["ApplicationNo"]);
                    String status = Config.ObjNav.FnForeignDetails(FName, docNo, FPhysicalLocation, FforeignCountry, FpostaLAddressPoBox, FtelephoneNoLocal, FemailAddrelocal,
                        Fwebsite, FacreeditationStatusForeign, FaccreditingForeign, tForeignAcademic, TForeignResearch);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        Session["ApplicationNo"] = info[2];
                        ForeignDetails.Visible = true;
                        foreignDetailz.Visible = false;
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

        protected void PostCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            string postcode = PostCode.SelectedValue;
            var nav = new Config().ReturnNav();
            var citys = nav.postcodes.Where(r => r.Code == postcode);
            foreach (var city in citys)
            {
                localCity.Text = city.City;
            }
        }

        protected void funds_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";

                string tdescription = sourceFunds.Text.Trim();
                string tApplicationNo = Convert.ToString(Session["ApplicationNo"]);

                decimal txtfees = 0;


                if (error)
                {
                    AgencyFacilities.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertSourceOfFunds(tApplicationNo, tdescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        sources.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        sources.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                sources.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void academicProgram_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";

                string tsubjectArea = SubjectArea.Text.Trim();
                string tApplicationNo = Request.QueryString["ApplicationNo"];
                int Ttitles = Convert.ToInt32(titles.Text.Trim());
                string tvolumes = volumes.Text.Trim();
                int tjournals = Convert.ToInt32(journals.Text.Trim());
                string tremarksCoreText = remarksCoreText.Text.Trim();


                decimal txtfees = 0;


                if (error)
                {
                    academicCollaboration.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    String status = Config.ObjNav.FnInsertCoreTextJournals(tApplicationNo, tsubjectArea, Ttitles, tvolumes, tjournals, tremarksCoreText);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        SubjectArea.Text = "";
                        titles.Text = "";
                        volumes.Text = "";
                        journals.Text = "";
                        remarksCoreText.Text = "";


                        academicCollaboration.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        academicCollaboration.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception m)
            {
                academicCollaboration.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previousSteps_Click1(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("ApplicationFinalReport.aspx?ApplicationNo=" + docNo);
        }

        protected void evidencePayment_Click(object sender, EventArgs e)
        {
            try
            {

                string paymentreference = PayRef.Text.Trim();
                string paymentMode = PaymentModes.SelectedValue.Trim();
                Decimal tAmount = Convert.ToDecimal(amountPaide.Text);
                String ApplicationNo = Request.QueryString["ApplicationNo"];
                var status = Config.ObjNav.FnConfirmPayment(ApplicationNo, paymentreference, paymentMode, tAmount,"");
                String[] info = status.Split('*');
                if (info[0] == "success")
                {


                    submit.Visible = true;

                    bool error = false;
                    string msg = "";
                    string accreditationNo = Request.QueryString["ApplicationNo"];
                    accreditationNo = accreditationNo.Replace('/', '_');
                    accreditationNo = accreditationNo.Replace(':', '_');
                    string path1 = ConfigurationManager.AppSettings["FilesLocation"] + "Collaboration Application/";
                    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Collaboration Application/";
                    string str1 = Convert.ToString(accreditationNo);
                    string folderName = path1 + str1 + "/";
                    bool paymentsDocUploaded = false;
                    try
                    {
                        if (FileUpload1.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filesFolder))
                                {
                                    String extension = System.IO.Path.GetExtension(FileUpload1.FileName);
                                    if (new Config().IsAllowedExtension(extension))
                                    {


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
                                            feedback.InnerHtml =
                                                                            "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                        }
                                        if (createDirectory)
                                        {
                                            string filename = documentDirectory + FileUpload1.FileName;
                                            if (File.Exists(filename))
                                            {
                                                feedback.InnerHtml =
                                                                                   "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                            }
                                            else
                                            {
                                                FileUpload1.SaveAs(filename);
                                                if (File.Exists(filename))
                                                {
                                                    Config.navExtender.AddLinkToRecord("Collaboration Card", ApplicationNo, filename, "");
                                                    var status1 = Config.ObjNav.FnAddDocumentsLinks(ApplicationNo, ApplicationNo, filename);
                                                    String[] info1 = status.Split('*');
                                                    if (info1[0] == "success")
                                                    {
                                                        feedback.InnerHtml =
                                                        "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                    }
                                                    else
                                                    {
                                                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info1[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                    }

                                                }
                                                else
                                                {
                                                    feedback.InnerHtml =
                                                        "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                }
                                            }
                                        }
                                    }
                                    else
                                    {
                                        feedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                                else
                                {
                                    feedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            catch (Exception ex)
                            {
                                feedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                        }
                    }
                    catch (Exception)
                    {
                        feedback.InnerHtml = ("The Payments Details Could Not Be Captured Kindly Contact the System Administrator");
                    }

                    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    previewReport.Visible = true;
                    evidencePayment.Visible = true;
                }


                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }




            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }

        protected void nextInvoice_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["ApplicationNo"];
            Response.Redirect("ProformaInvoice.aspx?ApplicationNo=" + docNo);
        }
    }
}