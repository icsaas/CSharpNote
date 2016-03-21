     using System.Web.Script.Serialization;
using ModelGroup.Model;

public partial class Admin_ProcessPage : System.Web.UI.Page
{
    JavaScriptSerializer serializer = new JavaScriptSerializer();
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request.QueryString["txt_search"].ToString();
        if (name.Equals("aaa")) {
            List zentag = new List();
            zentag.Add(new zen_tag {
                tag_id = 1,
                tag_name = "Nicholas",
                url_show = "Nicholas",
                first_letter = "N",
                count = 500,
                create_time = "2009-10-10 10:10"
            });
            string jsonStr = serializer.Serialize(zentag);
            Response.Clear();
            Response.Write(jsonStr);
            Response.End();
        }
    }
}