using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class MyProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string ApplicationNo = Convert.ToString(Session["ApplicationNo"]);
                var myprofile = nav.Recognition_Equation_Header.Where(x => x.Application_No == ApplicationNo).ToList();
                foreach (var p in myprofile)
                {
                    title.Text = p.Title;
                    firstname.Text = p.First_Name;
                    lastname.Text = p.Last_Name;
                    middlename.Text = p.Middle_Name;
                    email.Text = p.Email;
                    telephonenumber.Text = p.Telephone_No;
                    whatsappnumber.Text = p.Whatsapp_No;
                    idno.Text = Convert.ToString(p.ID_No);
                    passport.Text = p.ID_No_Passport_No;
                    postcode.Text = p.Post_Code;
                    city.Text = p.City;
                    country.Text = p.Country;
                    county.Text = p.Country;
                    citizenship.Text = p.Form_of_Citizenship;
                    nationality.Text = p.Nationality;
                    address.Text = p.Address;
                    string isemp = "";
                    if (p.Employed == true)
                    {
                        isemp = "YES";
                        txtemployed.Text = isemp;
                    }
                    else
                    {
                        isemp = "NO";
                        txtemployed.Text = isemp;
                    }
                    companyname.Text = p.Employer_Name;
                    department.Text = p.Field_Department;
                }
            }
        }
    }
}