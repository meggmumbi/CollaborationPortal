using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPortal
{
    public class Targets
    {
        public string TargetNumber { get; set; }
        public string checkbox_value { get; set; }
        public string ApplicationNo { get; set; }
        public string quantity { get; set; }
        public string adequacy { get; set; }
        public string comment { get; set; }
        public string category { get; set; }


        //Collaboration       
        public string capacity { get; set; }

        public string specificDpt { get; set; }
        public string shared { get; set; }

    }
}