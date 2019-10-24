<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.145
	 Created on:   	12/4/2017 2:56 PM
	 Created by:   	Matthew Nelson
	 Organization: 	Florida State University
	 Filename:     	Set-IRCamera	
	===========================================================================
	.DESCRIPTION
		Determines if another IR Camera is present and disables MS Surface IR at
		Start-up.
#>

$checkMSIR = [bool](Get-PnpDevice -FriendlyName "Microsoft IR Camera Front" | Where-Object {$_.Status -eq "OK"})
$checkBRIO = [bool](Get-PnpDevice -FriendlyName "Logitech BRIO")

If ($checkBRIO)
{
	Get-PnpDevice -FriendlyName "Microsoft IR Camera Front" | Disable-PnpDevice -Confirm:$false -ErrorAction Ignore
	Get-PnpDevice -FriendlyName "Logitech BRIO" | Where-Object {$_.Status -ne "OK"} | Enable-PnpDevice -Confirm:$false -ErrorAction Ignore
}
elseif ($checkMSIR)
{
	Get-PnpDevice -FriendlyName "Microsoft IR Camera Front" | Enable-PnpDevice -Confirm:$false -ErrorAction Ignore
}
