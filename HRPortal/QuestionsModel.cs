using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRPortal
{
    public class QuestionsModel
    {

        
        public string QuestionCode { get; set; }
        public string qnCategory { get; set; }
        public String response { get; set; }
        public string parentQnId { get; set; }
        public string QnCategory { get; set; }
        public string AnsOption { get; set; }

        public String applicationNo { get; set; }
       

    }
}