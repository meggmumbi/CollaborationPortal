using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class AppealApplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                var nav = new Config().ReturnNav();
                var appealReasons = nav.AppealReason.ToList();
                AppealReason.DataSource = appealReasons;
                AppealReason.DataTextField = "Description";
                AppealReason.DataValueField = "Code";
                AppealReason.DataBind();
                AppealReason.Items.Insert(0, new ListItem("--select--", ""));

                txtDate.Text =Convert.ToString(DateTime.Now);


            }



        }

        protected void Nexttostep2_Click(object sender, EventArgs e)
        {
            Response.Redirect("MyAppealApplications.aspx");
        }

        protected void addapplication_Click(object sender, EventArgs e)
        {
            //create kicense renewal voucher


            string tAppealReason = AppealReason.SelectedValue.Trim();
            string InstitutionNo = Convert.ToString(Session["InstitutionNo"]);
            string msg = "";
            bool error = false;

            if (string.IsNullOrEmpty(tAppealReason))
            {
                error = true;
                msg = "Appeal Reason Field must have a value. cannot be null or empty";
            }
           
            if (error)
            {
                linesfeedback.InnerHtml = "<div class='alert alert-success'>" + msg + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

                try
                {

                    var status = Config.ObjNav.FnSubmitAppealReason(InstitutionNo, tAppealReason);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        linesfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('MyAppealApplications.aspx') }, 5000);", true);
                    }
                    else
                    {
                        linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {

                    linesfeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void AppealReason_SelectedIndexChanged(object sender, EventArgs e)
        {
            string appealReason = AppealReason.SelectedValue.Trim();

            if (appealReason == "OTHERS")
            {
                others.Visible = true;
            }
            else
            {
                others.Visible = false;
            }
        }
    }
}