using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.Linq;
using System.ServiceProcess;

namespace ASMEmailServices
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : System.Configuration.Install.Installer
    {
        public ProjectInstaller()
        {
            InitializeComponent();
        }

        private void ProjectInstaller_Committed(object sender, InstallEventArgs e)
        {
            ServiceController sc = new ServiceController(ASMEmailServiceInstaller.ServiceName);
            sc.Start();
        } 
    }
}
