param 
   ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [string]$UserName,
		
		[Parameter(Mandatory)]
        [string]$Password,
		
        [Parameter(Mandatory)]
        [String]$setupLocation,

        [Parameter(Mandatory)]
        [String]$DeliveryController,
		
		[Parameter(Mandatory)]
        [String]$CreateMasterImage	
    ) 

		 
	New-Item -ItemType directory -Path "C:\VDISetup"
	Invoke-WebRequest -Uri $setupLocation -OutFile "C:\VDISetup\VDAWorkstationSetup_7.9.exe"

	$arguments = " /enable_real_time_transport /enable_hdx_ports /components vda,plugins /noreboot /PASSIVE /QUIET /controllers '$DeliveryController'"
	if([System.Convert]::ToBoolean($CreateMasterImage) -eq $true)
	{
		$arguments = $arguments + " /masterimage"
	}
					
	Start-Process "C:\VDISetup\VDAWorkstationSetup_7.9.exe"  -ArgumentList $arguments -Wait

	$DomainUser = $domainName  + "\" + $UserName
	$secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
	$creds = New-Object System.Management.Automation.PSCredential ($DomainUser, $secpasswd)
	Add-Computer -DomainName $DomainName -Credential $creds
	Restart-Computer