using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Certificate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void renewlicensebutton_Click(object sender, EventArgs e)
        {
            //create kicense renewal voucher

            string tlicenseNo = licenseNo.Text.Trim();
            string InstitutionNo = Convert.ToString(Session["InstitutionNo"]);
            string msg = "";
            bool error = false;

            if (string.IsNullOrEmpty(tlicenseNo))
            {
                error = true;
                msg = "License Number cannot be null or empty";
            }
            if (string.IsNullOrEmpty(InstitutionNo))
            {
                error = true;
                msg = "Institution Number cannot be null or empty";
            }
            if (error)
            {
                renewLicense.InnerHtml = "<div class='alert alert-success'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

                try
                {
                    var status = Config.ObjNav.FnLicenceVoucher(tlicenseNo, InstitutionNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        renewLicense.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('OpenRenewalApplications.aspx') }, 5000);", true);
                    }
                    else
                    {
                        renewLicense.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {

                    renewLicense.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }

        }
    }
}