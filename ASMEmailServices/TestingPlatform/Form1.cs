using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ASMLib;
using System.Configuration;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace TestingPlatform
{
    public partial class Form1 : Form
    {
        public static string smtpmailhost = "smtp.atmex.asmpt.com";
        private static System.Timers.Timer time { get; set; }
        private static System.Timers.Timer time2 { get; set; }
        private static BackgroundWorker bw { get; set; }
        private static BackgroundWorker bw2 { get; set; }
        asml al = new asml("ConnectionString");
        
        private void SendEmail(string Subject, string From, string To, string MsgBody)
        {
            MailMessage mail = new MailMessage(From, To);
            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            client.Host = smtpmailhost;
            mail.Subject = Subject;
            mail.Body = MsgBody;
            mail.IsBodyHtml = true; // to generate html text formating visit https://html-online.com/editor/
            client.Send(mail);
        }
        
        private static void GetDataRowValue(DataRow item, out string ID, out string Source, out string Status, out string cc, out string bcc, out string LastAttempt, out string Subject, out string From, out string To, out string MsgBody)
        {
            ID = item["ID"].ToString();
            Source = item["Source"].ToString();
            Subject = item["Subject"].ToString();
            Status = item["Status"].ToString();
            From = item["From"].ToString();
            To = item["To"].ToString();
            cc = item["cc"].ToString();
            bcc = item["bcc"].ToString();
            MsgBody = item["MsgBody"].ToString();
            LastAttempt = item["LastAttempt"].ToString();
        }
        
        private static void AddParamToList(List<SqlParameter> paramlist, SqlParameter paramID, SqlParameter paramstatus)
        {
            paramlist.Clear();
            paramlist.Add(paramID);
            paramlist.Add(paramstatus);
        }
        
        private void UpdateSQltblmsglist(List<SqlParameter> paramlist)
        {
            SqlConnection con = new SqlConnection(asml.connstr);
            con.Open();


            al.SQLExec("usp_UpdateMsgStatus", con, paramlist.ToArray(), CommandType.StoredProcedure);

            con.Close();
        }
        
        private void UpdateSQltblSchedulerStatus(List<SqlParameter> paramlist)
        {
            SqlConnection con = new SqlConnection(asml.connstr);
            con.Open();


            al.SQLExec("usp_UpdateSchedulerStatus", con, paramlist.ToArray(), CommandType.StoredProcedure);

            con.Close();
        }

        private void ProcessScheduler()
        {


            DataTable dt = al.SQLGetDatatable("usp_GetSchedulerList", CommandType.StoredProcedure);
            DataTable dtref = dt.Clone();
            DataTable Temptbl = dt.Clone();
            DataRow[] mydr;
            mydr = GetTodayRecurrency(dt, dtref);


            foreach (DataRow datarow in dtref.Rows)
            {
                

                DataTable dt2 = al.SQLGetDatatable(datarow["SprocName"].ToString(), CommandType.StoredProcedure);
                DataRow originalrow = dt.NewRow();

                



                foreach (DataRow item2 in dt2.Rows)
                {
                    Temptbl.ImportRow(datarow);

                    foreach (var datacol in dt.Columns)
                    {

                        ConvertDynamicDataFormatToActualData(datarow, Temptbl.Rows[0], item2, datacol);

                        

                    }



                    int ID = (int)datarow[0];

                    List<SqlParameter> paramlist = new List<SqlParameter>();
                    SqlParameter paramID = new SqlParameter("@ID", ID);
                    SqlParameter paramstatus = new SqlParameter("@Status", 1);



                    try
                    {
                        SendEmail(Temptbl.Rows[0]["Subject"].ToString(), Temptbl.Rows[0]["From"].ToString(), Temptbl.Rows[0]["To"].ToString(), Temptbl.Rows[0]["MsgBody"].ToString());
                    }
                    catch (Exception ex)
                    {
                        paramstatus.Value = 0;
                    }

                    AddParamToList(paramlist, paramID, paramstatus);
                    UpdateSQltblSchedulerStatus(paramlist);







                    

                    Temptbl.Rows.Clear();

                }

                


                


            }
        }

        private static void ConvertDynamicDataFormatToActualData(DataRow DataSource, DataRow RowToReplace, DataRow tablecontaindata, object columnlistfordynamicdatatable)
        {
            string varvalue = DataSource[columnlistfordynamicdatatable.ToString()].ToString();

            if (varvalue.Contains('[') && varvalue.Contains(']'))
            {

                MatchCollection mcol = Regex.Matches(varvalue, @"\[.*?\]");

                foreach (Match m in mcol)
                {
                    string vartext = (m.Value.Replace("[", "")).Replace("]", "");

                    try
                    {
                        string getdata = tablecontaindata[vartext].ToString();
                        varvalue = RowToReplace[columnlistfordynamicdatatable.ToString()].ToString();

                        RowToReplace[columnlistfordynamicdatatable.ToString()] = varvalue.Replace(m.Value, getdata);

                    }
                    catch (ArgumentException ex)
                    {

                    }
                    catch (Exception ex)
                    {

                    }




                }




            }
        }

        private static DataRow[] GetTodayRecurrency(DataTable dt, DataTable dtref)
        {
            DataRow[] mydr;
            switch (DateTime.Now.Date.DayOfWeek.ToString())
            {
                case "Monday":
                    mydr = dt.Select("recurrency like '%Monday%' or recurrency = '*' ");
                    break;
                case "Tuesday":
                    mydr = dt.Select("recurrency like '%Tuesday%' or recurrency =  '*' ");
                    break;
                case "Wednesday":
                    mydr = dt.Select("recurrency like '%Wednesday%' or recurrency = '*' ");
                    break;
                case "Thursday":
                    mydr = dt.Select("recurrency like '%Thursday%' or recurrency = '*' ");
                    break;
                case "Friday":
                    mydr = dt.Select("recurrency like '%Friday%' or recurrency = '*' ");
                    break;
                case "Saturday":
                    mydr = dt.Select("recurrency like '%Saturday%' or recurrency = '*' ");
                    break;
                case "Sunday":
                    mydr = dt.Select("recurrency like '%Sunday%' or recurrency = '*' ");
                    break;

                default:
                    mydr = dt.Select("recurrency like '%*%'");
                    break;
            }


            foreach (DataRow drow in mydr)
            {
                dtref.ImportRow(drow);
            }

            return mydr;
        }

        private void ProcessEmail()
        {
            DataTable dt = al.SQLGetDatatable("usp_GetPendingMsgList", CommandType.StoredProcedure);

            foreach (DataRow item in dt.Rows)
            {
                string Subject;
                string From;
                string To;
                string MsgBody;
                string ID;
                string Source;
                string Status;
                string cc;
                string bcc;
                string LastAttempt;

                GetDataRowValue(item, out ID, out Source, out Status, out cc, out bcc, out LastAttempt, out Subject, out From, out To, out MsgBody);


                List<SqlParameter> paramlist = new List<SqlParameter>();
                SqlParameter paramID = new SqlParameter("@ID", ID);
                SqlParameter paramstatus = new SqlParameter("@Status", 1);



                try
                {
                    SendEmail(Subject, From, To, MsgBody);
                }
                catch (Exception ex)
                {
                    paramstatus.Value = 0;
                }

                AddParamToList(paramlist, paramID, paramstatus);
                UpdateSQltblmsglist(paramlist);

            }


        }

        private void SetupBackgroundWorker()
        {
            bw = new BackgroundWorker();
            bw.WorkerReportsProgress = true;
            bw.WorkerSupportsCancellation = true;
            bw.DoWork += Bw_DoWork;
            bw.RunWorkerCompleted += Bw_RunWorkerCompleted;

            bw2 = new BackgroundWorker();
            bw2.WorkerReportsProgress = true;
            bw2.WorkerSupportsCancellation = true;
            bw2.DoWork += Bw2_DoWork;
            bw2.RunWorkerCompleted += Bw2_RunWorkerCompleted;
        }

        private void SetupTimer()
        {
            time = new System.Timers.Timer();

            time.Enabled = true;
            time.Interval = 1000;
            time.Elapsed += Time_Tick;
        }

        private void SetupTimer2()
        {
            time2 = new System.Timers.Timer();

            time2.Enabled = true;
            time2.Interval = 1000;
            time2.Elapsed += Time2_Tick;
        }

        private void Time_Tick(object sender, EventArgs e)
        {
            if (!bw.IsBusy)
            {
                bw.RunWorkerAsync();
            }

        }

        private void Time2_Tick(object sender, EventArgs e)
        {
            if (!bw2.IsBusy)
            {
                bw2.RunWorkerAsync();
            }

        }

        private void Bw_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            time.Enabled = true;
        }

        private void Bw2_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            time2.Enabled = true;
        }
        
        private void Bw2_DoWork(object sender, DoWorkEventArgs e)
        {
            time2.Enabled = false;
            ProcessScheduler();
        }
        
        private void Bw_DoWork(object sender, DoWorkEventArgs e)
        {
            time.Enabled = false;
            ProcessEmail();
            
        }

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            
            
            
            SetupBackgroundWorker();
            SetupTimer();
            SetupTimer2();


        }





    }
}
