# Citrix Cloud XenDesktop Resource Location Creation ARM Template

This template creates a fully self-contained Resource Location for either Citrix XenDesktop service or Citrix XenDesktop Essentials Service, consisting of the following resources:

* Windows Domain Controller
* Citrix NetScaler VPX 11.1
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

*  At least 20 Cores should be available within your Azure subscription.
*  For subscription used to deploy this Azure ARM Template, Want to deploy programmatically? option must be enabled for [Citrix NetScaler 11.1 VPX Bring Your Own License](https://portal.azure.com/#create/citrix.netscalervpx111netscalerbyol)  offer within Azure Marketplace.
*  If you want to deploy Windows 10 HUB image, make sure your Azure subscription is part of Azure Enterprise Agreement.	
*  Login to https://citrix.cloud.com/  
		*  Navigate to "Identity and Access Management".  		
		*  Click "API Access".		
		*  Enter a name for Secure Client and click Create Client.
		*  Once Secure Client is created, download Secure Client Credentials file.
		*  Note down :
                	id	=>	Passed as parameter for customerId.
               		Secret	=>	Passed as parameter for clientSecret.
* Login to https://www.Citrix.com
	Download latest RTM version of [Desktop OS Virtual Delivery Agent](https://www.citrix.com/downloads/xenapp-and-xendesktop/product-software/xenapp-and-xendesktop-714.html) for Windows 10 VDA
	Download latest RTM version of [Server OS Virtual Delivery Agent](https://www.citrix.com/downloads/xenapp-and-xendesktop/product-software/xenapp-and-xendesktop-714.html) for Windows Server VDA
	Upload it to a share that can be accessed by Azure Resource Manager Template.

# Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcitrix%2FCitrix-Cloud-ResourceLocation-Arm-Template%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fcitrix%2FCitrix-Cloud-ResourceLocation-Arm-Template%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

# Template parameters:

	
| Name   | Description    |
|:--- |:---|
| vhdStorageType | Specifies the type of storage account, if being created. | 
| vhdStorageNewOrExisting | Specifies whether the storage account should be created or already exists. | 
| publicIpName | Specifies the resource name for the public IP. New IPs will take this name, while references to existing ones should be valid. | 
| publicIpNewOrExisting | Specifies whether the public IP should be created or already exists. | 
| machineSize | Specifies the size of the virtual machines (6). | 
| adminUsername | Specifies the name of the administrator for machines, Active Directory domain, NetScaler and XenApp. Exclusion list: 'admin','administrator'. Must be no more than 9 alphanumeric characters. | 
| adminPassword | Specifies the password of the administrator for machines, Active Directory domain, NetScaler and XenApp. | 
| domainName | Specifies the name of the newly created Active Directory domain. | 
| emailAddress | Specifies the email address that that will be used to request a public SSL certificate for NetScaler gateway from letsencrypt.org on your behalf. This will also be used to notify you when the template has deployed successfully. | 
| acmeServer | Specifies the ACME protocol server used for public TLS certificate requests. Allowed values correspond to letsencrypt.org  or any certficate provision service. | 
| customInboundRules | Specifies additional inbound NAT rules to apply in this deployment. Useful for exposing individual machines more directly. The parameter is specified as an object, as in the default. See variable 'loadBalancerSettings' for an example format. | 
| customApplications | Specifies additional applications to be installed on the VDA and published through XenApp. The parameter is specified as an array of objects, as in the default. See variables 'applications', 'vdaSettings', and 'storeFrontSettings' for an example format.  | 
| artifactsBaseUrl | Specifies the base location of the child templates and desired state configuration scripts. | 
| artifactsBaseUrlSasToken | Specifies the shared access signature token which provides access to the base artifacts location. | 
| Azure Gov | Specify True if the deployment is for Azure Gov, otherwise false. |
| Customer | This is the customer ID available in the Citrix Cloud console on the API Access page (within Identity and Access Management). |
| clientID | Found on the API Access page. This is the secure client ID an administrator can create.|
| clientSecret | Found on the API Access page. This is the secure client secret available via download after a secure client is created. |
| ResourceLocationId | Specify a Name for a resourcelocation to be created on Citrix Cloud, if there is no resource location available, enter a new ResourceLocation Name |
| CreateMasterImage | Specify if you want the VDI to be created as master Image, Note: If this option is specified the VDI are not provisioned to DDC. |
| CustomCloudConnectorScriptUri | If you want to run any custom configuration on cloudConnector, specify the URL for the powershellScript. else leave it empty. |
| CustomCloudConnectorScriptArgs | Arguments for Script, else leave it blank.|
| CreateClientVDA | Creates a Windows 10 [HUB] CBB Image, if your subscription is not part of Azure Enterprise Agreement, choose "false", the ARM Template will not create Windows 10 [HUB] CBB VM.|
| ClientVDIInstallerUri | Url for the Standalone Desktop OS Virtual Delivery Agent Installer, which can be download [here](https://www.citrix.com/downloads/xenapp-and-xendesktop/product-software/xenapp-and-xendesktop-714.html). |
| CreateServerVDA | If you select "True", ARM Template creates a Windows Server 2016 Server VDA. |
| ServerVDAInstallerUrl | The Standalone Server OS Virtual Delivery Agent Installer, which can be downloaded [here](https://www.citrix.com/downloads/xenapp-and-xendesktop/product-software/xenapp-and-xendesktop-714.html).|

# ARM Template Parameters Examples:


| Example File  | Description    |
|:--- |:---|
| parameters.vda.json	| Example for Creating both Citrix Client VDI and Server VDI.|
| parameters.win10.vda.json 	| Example for Creating only Citrix Client VDI. |
| parameters.winserver2016.vda.json |  Example for Creating only Citrix Server VDI. |

