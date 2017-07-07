# Citrix Cloud Xendesktop Resource Location Creation Arm Template

This template demonstrates the creation of a self-contained XenDesktop environment in Azure, creating the following resources:

* Domain Controller
* Citrix NetScaler VPX 11.0
* Citrix Virtual Desktop Agents (1 Client Windows 10 VDI)
* Citrix CloudConnector
* RDP JumpBox

After deployment, fallowing components are fully configured with Citrix Cloud customer XenDesktop instance:

1. A new user-specified Active Directory domain is created and the machines are automatically joined to it.
2. A Citrix CloudConnector VM is created and Joined to specified Customer Account from https://citrix.cloud.com.
3. VDAs are provisioned and joined to Citrix XenDesktop Infrastructure running in Citrix Cloud.
5. A certificate is obtained for the deployment from the letsencrypt certificate authority.
6. NetScaler VPX is configured as a gateway to the deployment.

# Pre-Requisites

In order for template to Work, these are the fallowing Requirements.

	1. Make sure there are at least 10 Core available for DS_V2.
	2. Enable Programmatic Deployment for NetScaler VPX 11.0.
	3. Make sure the subscription is part of Azure Enterprise Agreement.
	4. Navigate to https://citrix.cloud.com/
		a. Navigate to "Identity and Access Management".
		b. Click "API Access".
		c. Enter a name for Secure Client and click Create Client.
		d. Once Secure Client is created, download Secure Client Credentials file.
		e. Note down :
			id		=>	Passed as parameter for customerId.
			Secret	=>	Passed as parameter for clientSecret.
	5. Login to https://www.Citrix.com
		Download latest RTM version of Standalone Client VDI Installer.
		Upload it to a share that can be accessed by Azure Resource Manager Template.


Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fkkuenterprisestorage.blob.core.windows.net%2Fcctest18-stageartifacts%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

Template parameters:

| Name   | Description    |
|:--- |:---|
| vhdStorageAccount | Specifies the name of the storage account used for virtual machine disks. This has to be a unique name, up to 24 chars, all lowercase. | 
| vhdStorageType | Specifies the type of storage account, if being created. | 
| vhdStorageGroup | Specifies the resource group which should contain the storage account. | 
| vhdStorageNewOrExisting | Specifies whether the storage account should be created or already exists. | 
| userImageContainerName | Specifies a storage container in the account specified by 'vhdStorageAccount' in which user images of XenApp 7.7 reside. | 
| imageType | Specifies whether the template should deploy from the Azure Marketplace gallery or from user images in the storage account specified by 'vhdStorageAccount.' | 
| imageQualifier | Specifies an additional qualifier to use for Marketplace image references. The value 'preview' is for images in staging, while the default value references production images. | 
| publicDnsName | Specifies a unique public DNS prefix for the deployment. This will produce a FQDN of the form '<publicDnsName>.<location>.cloudapp.azure.com'. Up to 62 chars, digits or dashes, lowercase, should start with a letter: must conform to '^[a-z][a-z0-9-]{1,61}[a-z0-9]. | 
| publicIpGroup | Specifies the resource group which should contain the public IP. | 
| publicIpName | Specifies the resource name for the public IP. New IPs will take this name, while references to existing ones should be valid. | 
| publicIpNewOrExisting | Specifies whether the public IP should be created or already exists. | 
| machineSize | Specifies the size of the virtual machines (6). | 
| adminUsername | Specifies the name of the administrator for machines, Active Directory domain, NetScaler and XenApp. Exclusion list: 'admin','administrator'. Must be no more than 9 alphanumeric characters. | 
| adminPassword | Specifies the password of the administrator for machines, Active Directory domain, NetScaler and XenApp. | 
| domainName | Specifies the name of the newly created Active Directory domain. | 
| emailAddress | Specifies the email address that that will be used to request a public SSL certificate for NetScaler gateway from letsencrypt.org on your behalf. This will also be used to notify you when the template has deployed successfully. | 
| acmeServer | Specifies the ACME protocol server used for public TLS certificate requests. Allowed values correspond to letsencrypt.org staging or production. | 
| customInboundRules | Specifies additional inbound NAT rules to apply in this deployment. Useful for exposing individual machines more directly. The parameter is specified as an object, as in the default. See variable 'loadBalancerSettings' for an example format. | 
| customApplications | Specifies additional applications to be installed on the VDA and published through XenApp. The parameter is specified as an array of objects, as in the default. See variables 'applications', 'vdaSettings', and 'storeFrontSettings' for an example format.  | 
| artifactsBaseUrl | Specifies the base location of the child templates and desired state configuration scripts. | 
| artifactsBaseUrlSasToken | Specifies the shared access signature token which provides access to the base artifacts location. | 
| Azure Gov | Specify True if the deployment is for Azure Gov, otherwise false. |
| XA Controller Deploy Type | For Citrix Cloud Provisioning select CloudConnectorSettings, otherwise delivery Controller Settings.|
| Customer | This is the customer ID available in the Citrix Cloud console on the API Access page (within Identity and Access Management). |
| clientID | Found on the API Access page. This is the secure client ID an administrator can create.|
| clientSecret | Found on the API Access page. This is the secure client secret available via download after a secure client is created. |
| ResourceLocationId | Specify a Name for a resourcelocation to be created on Citrix Cloud. |
| DeploymentType | XenDesktop for Xendesktop Deployment, or XenApp for XenApp Deployment. |
| UseTestControlPlane | Default False, and Always set it to false. |
| CreateMasterImage | Specify if you want the VDI to be created as master Image, Note: If this option is specified the VDI are not provisioned to DDC. |
| CustomCloudConnectorScriptUri | If you want to run any custom configuration on cloudConnector, specify the URL for the powershellScript. else leave it empty. |
| CustomCloudConnectorScriptArgs | Arguments for Script, else leave it blank.|
| CreateClientVDI | Creates a Windows 10 Hub Image, if your subscription is not part of Azure Enterprise Agreement, set it to false.|
| ClientVDIInstallerUri | Url for the Standalone Client VDI Installer, which can be download from https://www.citrix.com website. |
| CreateSharedHostedVDI | If True, creates a Windows Server 2016 Shared Hosted VDI. |
| SharedHostedVDIInstallerUri | The Standalone Installer for the Xendesktop VDI, which can be downloaded from https://www.citrix.com.|
