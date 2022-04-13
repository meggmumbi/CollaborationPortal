using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                String tUsername = email.Text.Trim();
                String tPassword = password.Text.Trim();
                var nav = new Config().ReturnNav();
                var users = nav.DynasoftPortalUser.Where(r => r.Authentication_Email == tUsername && r.Password_Value == tPassword && r.Record_Type == "Customer" && r.Record_ID != null);
                Boolean exists = false;
                foreach (var user in users)
                {
                    exists = true;
                    Session["name"] = user.Full_Name;
                    Session["email"] = user.Authentication_Email;
                    Session["phoneNo"] = user.Mobile_Phone_No;
                    Session["passwordValue"] = user.Password_Value;                 
                    Session["InstitutionNo"] = user.Record_ID;
                    if (user.Change_Password == false)
                    {
                        Response.Redirect("ChangePassword.aspx");
                    }
                }
                if (!exists)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter correct email address and password!<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    Response.Redirect("Dashboard.aspx");
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced a problem while processing your request, kindly try again! '" + ex.Message + "'</div>";

            }
        }

        //protected void register_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("Register.aspx");
        //}

        //protected void resetpassword_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("ResetPassword.aspx");
        //}
    }
}