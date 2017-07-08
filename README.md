# Citrix Cloud Xendesktop Resource Location Creation ARM Template

This template creates a fully self-contained Resource Location for XenApp and XenDesktop service in Citrix Cloud, consisting of the following resources:

* Windows Domain Controller
* Citrix NetScaler VPX 11.0
* Citrix Virtual Delivery Agent (VDAs)
	* Windows 10 HUB [CBB]
	* Windows Server 2016
* Citrix CloudConnector
* RDP JumpBox
* Azure Loadbalancer
* Azure VNET
* Azure Storage Account
* Azure Availability Set


# Pre-Requisites

Here are the pre-requisites before you invoke the template:

	1. At least 20 Cores should be available within your Azure subscription.
	2. For that subscription, <a href="https://portal.azure.com/#create/citrix.netscalervpx110-6531netscalerbyol" /a>“Want to deploy programmatically?” option must be enabled for "Citrix NetScaler 11.0 VPX Bring Your Own License" offer within Azure Marketplace.
	3. If you want to deploy Windows 10 HUB image, make sure your Azure subscription is part of Azure Enterprise Agreement.
	4. Navigate to https://citrix.cloud.com/
		a. Navigate to "Identity and Access Management".
		b. Click "API Access".
		c. Enter a name for Secure Client and click Create Client.
		d. Once Secure Client is created, download Secure Client Credentials file.
		e. Note down :
			id	=>	Passed as parameter for customerId.
			Secret	=>	Passed as parameter for clientSecret.
	5. Login to https://www.Citrix.com
		Download latest RTM version of Server OS Virtual Delivery Agent for Windows 10 VDA
		Download latest RTM version of Desktop OS Virtual Delivery Agent for Windows Server VDA
		Upload it to a share that can be accessed by Azure Resource Manager Template.


Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcitrix%2FCitrix-Cloud-ResourceLocation-Arm-Template%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


Template parameters:

Template Parameters ( refer to parameters.json to see sample parameter.)

| Name   | Description    |
|:--- |:---|
| vhdStorageType | Specifies the type of storage account, if being created. | 
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
