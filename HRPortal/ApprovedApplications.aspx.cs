using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ApprovedApplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ConfirmPayments_Click(object sender, EventArgs e)
        {
            try
            {
                bool error = false;
                string msg = "";
                string accreditationNo = accreditationnumber.Text.Trim();
                accreditationNo = accreditationNo.Replace('/', '_');
                accreditationNo = accreditationNo.Replace(':', '_');
                string path1 = ConfigurationManager.AppSettings["FilesLocation"] + "License Application/";
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "License Application/";
                string str1 = Convert.ToString(accreditationNo);
                string folderName = path1 + str1 + "/";
                bool paymentsDocUploaded = false;
                if (!paymentdocument.HasFile)
                {
                    error = true;
                    msg += msg.Length > 0 ? "<br/>" : "";
                    msg += "Please attach payment document to proceed";
                }
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    try
                    {
                        if (paymentdocument.HasFile)
                        {
                            try
                            {
                                if (Directory.Exists(filesFolder))
                                {
                                    String extension = System.IO.Path.GetExtension(paymentdocument.FileName);
                                    if (new Config().IsAllowedExtension(extension))
                                    {

                                        String ApplicationNo = accreditationnumber.Text.Trim();
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
                                            string filename = documentDirectory + paymentdocument.FileName;
                                            if (File.Exists(filename))
                                            {
                                                feedback.InnerHtml =
                                                                                   "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                            }
                                            else
                                            {
                                                paymentdocument.SaveAs(filename);
                                                if (File.Exists(filename))
                                                {
                                                    string tModesOfPayment = ModesOfPayment.SelectedValue;
                                                    string paymentreference = paymentsref.Text.Trim();
                                                    Config.navExtender.AddLinkToRecord("License_Application Card", ApplicationNo, filename, "");
                                                    var status = Config.ObjNav.FnConfirmPayment(ApplicationNo, paymentreference, tModesOfPayment,0,"");
                                                    String[] info = status.Split('*');
                                                    if (info[0] == "success")
                                                    {
                                                        feedback.InnerHtml =
                                                        "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                    }
                                                    else
                                                    {
                                                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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


                }
            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
    }
}