namespace ASMEmailServices
{
    partial class ProjectInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.ASMEmailServiceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.ASMEmailServiceInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // ASMEmailServiceProcessInstaller
            // 
            this.ASMEmailServiceProcessInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.ASMEmailServiceProcessInstaller.Password = null;
            this.ASMEmailServiceProcessInstaller.Username = null;
            // 
            // ASMEmailServiceInstaller
            // 
            this.ASMEmailServiceInstaller.DisplayName = "ASMEmailServices";
            this.ASMEmailServiceInstaller.ServiceName = "ASMEmailServices";
            this.ASMEmailServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.ASMEmailServiceProcessInstaller,
            this.ASMEmailServiceInstaller});
            this.Committed += new System.Configuration.Install.InstallEventHandler(this.ProjectInstaller_Committed);

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller ASMEmailServiceProcessInstaller;
        private System.ServiceProcess.ServiceInstaller ASMEmailServiceInstaller;
    }
}